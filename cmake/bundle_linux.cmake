# whisper-dev: bundles the GPU runtimes of the Linux backends into dlls/, so
# the folder runs on Linux systems without the CUDA toolkit or ROCm
# installed (one build for every Linux variant). Run by the 'dlls' target:
#
#   cmake -DDEST=<dlls folder> -DROOTS=<cuda root>;<rocm root>
#         -DHIP_TARGETS=gfx1030;gfx1100;... -P bundle_linux.cmake
#
# - Every library that libggml-cuda.so / libggml-hip.so needs, directly or
#   through others, and that lives under one of ROOTS (CUDA's cudart,
#   cuBLAS, cuBLASLt; ROCm's amdhip64, hipBLAS, rocBLAS, HSA, comgr, ...)
#   is copied into DEST under the name it is needed by (the soname).
# - Their RUNPATH is set to $ORIGIN (patchelf), so they find each other in
#   DEST like whisper-dev's own libraries; without patchelf a warning.
# - rocBLAS / hipBLASLt kernel files go to DEST/rocblas/library and
#   DEST/hipblaslt/library: only those for HIP_TARGETS, and the files for
#   no particular GPU.
# - NOT bundled: the GPU drivers (libcuda.so from NVIDIA's driver; the
#   kernel's amdgpu), and system libraries outside ROOTS - those the
#   bundled ones need are listed, to check on the target systems.
# MODULES (optional) replaces the two backends (for testing the script).
cmake_minimum_required(VERSION 3.21)

# lists come '|'-separated from the build (a ';' would split the argument)
string(REPLACE "|" ";" ROOTS "${ROOTS}")
string(REPLACE "|" ";" HIP_TARGETS "${HIP_TARGETS}")

if (NOT DEFINED MODULES)
    set(MODULES)
    foreach (_m ggml-cuda ggml-hip)
        if (EXISTS "${DEST}/lib${_m}.so")
            list(APPEND MODULES "${DEST}/lib${_m}.so")
        endif()
    endforeach()
endif()
if (NOT MODULES)
    return()
endif()

# the SDK folders, with their links resolved (/opt/rocm is usually a link
# to /opt/rocm-7.x; NVIDIA's packages register /usr/local/cuda-13/... -
# links - with the system loader): a library is bundled when its REAL
# path is inside one of them (comparing the paths as found missed every
# CUDA library: whisper-dev-07 bundled none)
set(_real_roots)
set(_dirs)
foreach (_r ${ROOTS})
    if (NOT EXISTS "${_r}")
        continue()
    endif()
    file(REAL_PATH "${_r}" _rr)
    list(APPEND _real_roots "${_rr}/")
    foreach (_p "${_r}" "${_rr}")
        foreach (_l lib lib64 targets/x86_64-linux/lib)
            if (IS_DIRECTORY "${_p}/${_l}")
                list(APPEND _dirs "${_p}/${_l}")
            endif()
        endforeach()
    endforeach()
endforeach()
if (NOT _real_roots)
    message(WARNING "whisper-dev: no SDK folder to bundle from (ROOTS='${ROOTS}')")
    return()
endif()

file(GET_RUNTIME_DEPENDENCIES
    LIBRARIES ${MODULES}
    RESOLVED_DEPENDENCIES_VAR _all
    UNRESOLVED_DEPENDENCIES_VAR _missing
    DIRECTORIES ${_dirs} "${DEST}"
    # whisper-dev's own (already in DEST) and the NVIDIA driver's
    PRE_EXCLUDE_REGEXES "^libggml" "^libwhisper" "^libgomp" "^libcuda\\.so")
set(_deps)
set(_already)
file(REAL_PATH "${DEST}" _real_dest)
foreach (_d ${_all})
    file(REAL_PATH "${_d}" _real)
    # bundled by an earlier run: found in DEST through RUNPATH $ORIGIN
    string(FIND "${_real}" "${_real_dest}/" _in_dest)
    if (_in_dest EQUAL 0)
        get_filename_component(_n "${_d}" NAME)
        list(APPEND _already "${_n}")
        continue()
    endif()
    foreach (_root ${_real_roots})
        string(FIND "${_real}" "${_root}" _at)
        if (_at EQUAL 0)
            list(APPEND _deps "${_d}")
            break()
        endif()
    endforeach()
endforeach()
list(REMOVE_DUPLICATES _deps)
if (_already)
    list(JOIN _already " " _already_text)
    message(STATUS "whisper-dev: GPU runtime already in ${DEST}: ${_already_text}")
endif()
if (NOT _deps AND NOT _already)
    message(STATUS "whisper-dev: the GPU backends need nothing from ${ROOTS} (resolved: ${_all}; not found: ${_missing})")
endif()

set(_copied)
foreach (_d ${_deps})
    get_filename_component(_n "${_d}" NAME)
    file(REAL_PATH "${_d}" _real)
    file(COPY_FILE "${_real}" "${DEST}/${_n}" ONLY_IF_DIFFERENT)
    list(APPEND _copied "${DEST}/${_n}")
    # kernel files beside rocBLAS / hipBLASLt (they look in <own folder>/
    # rocblas/library and hipblaslt/library): files named after a GPU, or
    # (ROCm 7.x) a folder per GPU, only for HIP_TARGETS; the rest all
    foreach (_k rocblas hipblaslt)
        if (_n MATCHES "^lib${_k}\\.so")
            get_filename_component(_from "${_real}" DIRECTORY)
            set(_from "${_from}/${_k}/library")
            if (IS_DIRECTORY "${_from}")
                file(MAKE_DIRECTORY "${DEST}/${_k}/library")
                file(GLOB _files RELATIVE "${_from}" "${_from}/*")
                set(_n_files 0)
                foreach (_f ${_files})
                    set(_take OFF)
                    if (NOT _f MATCHES "gfx[0-9a-f]+")
                        set(_take ON)
                    else()
                        foreach (_t ${HIP_TARGETS})
                            if (_f MATCHES "${_t}([^0-9a-f]|$)")
                                set(_take ON)
                            endif()
                        endforeach()
                    endif()
                    if (_take AND IS_DIRECTORY "${_from}/${_f}")
                        # ROCm 7.x: a folder per GPU (hipblaslt/library/gfx1100/...)
                        file(COPY "${_from}/${_f}" DESTINATION "${DEST}/${_k}/library")
                        file(GLOB_RECURSE _sub "${_from}/${_f}/*")
                        list(LENGTH _sub _n_sub)
                        math(EXPR _n_files "${_n_files} + ${_n_sub}")
                    elseif (_take)
                        file(COPY_FILE "${_from}/${_f}" "${DEST}/${_k}/library/${_f}" ONLY_IF_DIFFERENT)
                        math(EXPR _n_files "${_n_files} + 1")
                    endif()
                endforeach()
                message(STATUS "whisper-dev: ${_n_files} ${_k} kernel file(s) for ${HIP_TARGETS}")
            endif()
        endif()
    endforeach()
endforeach()

# $ORIGIN: the bundled libraries find each other (and nothing of the SDK)
find_program(_patchelf patchelf)
if (_patchelf)
    foreach (_f ${_copied})
        execute_process(COMMAND "${_patchelf}" --set-rpath "$ORIGIN" "${_f}" RESULT_VARIABLE _r)
        if (NOT _r EQUAL 0)
            message(WARNING "whisper-dev: patchelf failed on ${_f}")
        endif()
    endforeach()
elseif (_copied)
    message(WARNING "whisper-dev: patchelf not found - the bundled GPU runtime libraries keep their own "
        "RUNPATH and may not find each other on a system without the SDK (install patchelf)")
endif()

list(LENGTH _copied _n_copied)
message(STATUS "whisper-dev: ${_n_copied} GPU runtime librar(ies) bundled from ${ROOTS}")

# what the bundled set still needs from the system (to be there on the
# target systems: glibc, libstdc++, libdrm, libnuma, ... )
if (_copied)
    file(GET_RUNTIME_DEPENDENCIES
        LIBRARIES ${MODULES} ${_copied}
        RESOLVED_DEPENDENCIES_VAR _sys
        UNRESOLVED_DEPENDENCIES_VAR _sys_missing
        DIRECTORIES "${DEST}"
        PRE_EXCLUDE_REGEXES "^libggml" "^libwhisper" "^libgomp" "^libcuda\\.so"
        POST_EXCLUDE_REGEXES "^${DEST}/")
    set(_names)
    foreach (_s ${_sys})
        get_filename_component(_n "${_s}" NAME)
        list(APPEND _names "${_n}")
    endforeach()
    list(REMOVE_DUPLICATES _names)
    list(JOIN _names " " _names)
    message(STATUS "whisper-dev: system libraries the bundled set needs: ${_names}")
endif()
