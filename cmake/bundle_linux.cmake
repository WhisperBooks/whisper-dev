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
# - Licences: each bundled library's (and libgomp's) Debian copyright file
#   and NVIDIA's EULA.txt into DEST/licences/ (CUDA-*, ROCm-*, GCC-*), for
#   whoever ships the folder (dpkg needed: the container has it).
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

# $ORIGIN: the bundled libraries find each other (and nothing of the SDK).
# Also the ones an earlier run copied (a run that stopped before this step
# left them unpatched), and the backends themselves: CMake gives a HIP
# module no RUNPATH, so libggml-hip.so found libhipblas & co. only where
# ROCm is installed.
set(_patch ${MODULES} ${_copied})
foreach (_n ${_already})
    list(APPEND _patch "${DEST}/${_n}")
endforeach()
find_program(_patchelf patchelf)
if (_patchelf)
    foreach (_f ${_patch})
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
if (_n_copied GREATER 0)
    message(STATUS "whisper-dev: ${_n_copied} GPU runtime librar(ies) bundled from ${ROOTS}")
endif()

# what the bundled set still needs from the system (to be there on the
# target systems: glibc, libstdc++, libdrm, libnuma, ... )
# (also when an earlier run bundled them all: the list is the same)
set(_bundled ${_copied})
foreach (_n ${_already})
    list(APPEND _bundled "${DEST}/${_n}")
endforeach()
if (_bundled)
    file(GET_RUNTIME_DEPENDENCIES
        LIBRARIES ${MODULES} ${_bundled}
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

# licences of what is bundled, for whoever ships dlls/: each library's
# Debian package and its copyright file (/usr/share/doc/<package>/
# copyright) into DEST/licences/ as CUDA-<package>-copyright.txt or
# GCC-<package>-copyright.txt (libgomp, copied by the build itself),
# NVIDIA's CUDA EULA.txt, and ROCm's component licences
# (ROCm-<component>-<file>).
find_program(_dpkg dpkg)
set(_lic_names ${_already})
foreach (_f ${_copied})
    get_filename_component(_n "${_f}" NAME)
    list(APPEND _lic_names "${_n}")
endforeach()
if (EXISTS "${DEST}/libgomp.so.1")
    list(APPEND _lic_names libgomp.so.1)
endif()
if (_dpkg AND _lic_names)
    file(MAKE_DIRECTORY "${DEST}/licences")
    set(_lic_count 0)
    set(_no_pkg)
    set(_seen)
    foreach (_n ${_lic_names})
        execute_process(COMMAND "${_dpkg}" -S "*/${_n}" OUTPUT_VARIABLE _out ERROR_QUIET RESULT_VARIABLE _r)
        if (NOT _r EQUAL 0 OR _out STREQUAL "")
            list(APPEND _no_pkg "${_n}")
            continue()
        endif()
        string(REPLACE "\n" ";" _lines "${_out}")
        foreach (_l ${_lines})
            # "package[:arch][, package...]: /path"
            if (NOT _l MATCHES "^([^:,]+)[^ ]*: (.*)$")
                continue()
            endif()
            set(_pkg "${CMAKE_MATCH_1}")
            set(_path "${CMAKE_MATCH_2}")
            # only the package of the file that was bundled: the name can
            # be in others too (libgomp.so.1: lib32gomp1, libx32gomp1 and
            # ROCm's LLVM have one each)
            if (_n MATCHES "^libgomp")
                if (NOT _path MATCHES "^/usr/lib/x86_64-linux-gnu/|^/usr/lib/aarch64-linux-gnu/")
                    continue()
                endif()
            else()
                set(_under OFF)
                foreach (_root ${_real_roots} ${ROOTS})
                    string(FIND "${_path}" "${_root}" _at)
                    if (_at EQUAL 0)
                        set(_under ON)
                    endif()
                endforeach()
                if (NOT _under)
                    continue()
                endif()
            endif()
            if (_pkg IN_LIST _seen)
                continue()
            endif()
            list(APPEND _seen "${_pkg}")
            if (_path MATCHES "/cuda")
                set(_group CUDA)
            elseif (_path MATCHES "/rocm")
                set(_group ROCm)
            elseif (_n MATCHES "^libgomp")
                set(_group GCC)
            else()
                set(_group System)
            endif()
            if (EXISTS "/usr/share/doc/${_pkg}/copyright")
                file(COPY_FILE "/usr/share/doc/${_pkg}/copyright"
                    "${DEST}/licences/${_group}-${_pkg}-copyright.txt" ONLY_IF_DIFFERENT)
                math(EXPR _lic_count "${_lic_count} + 1")
            endif()
        endforeach()
    endforeach()
    # ROCm 7.x packages (amdrocm-*) have no /usr/share/doc entry: each
    # component keeps its licence in <ROCm>/share/doc/<component>/ (hip,
    # hipblaslt, rocblas, amd_comgr, ...; LLVM's under lib/llvm). All of
    # them are copied - more texts than libraries, but none missing.
    set(_rocm_docs)
    foreach (_r ${ROOTS})
        if (NOT _r MATCHES "rocm")
            continue()
        endif()
        foreach (_base "${_r}" "${_r}/*" "${_r}/*/lib/llvm" "${_r}/lib/llvm")
            foreach (_pat LICENSE* License* license* LICENCE* COPYING* NOTICE* copyright)
                file(GLOB _found "${_base}/share/doc/*/${_pat}" "${_base}/${_pat}")
                list(APPEND _rocm_docs ${_found})
            endforeach()
        endforeach()
    endforeach()
    set(_rocm_real)
    foreach (_f ${_rocm_docs})
        if (IS_DIRECTORY "${_f}")
            continue()
        endif()
        file(REAL_PATH "${_f}" _rf)
        if (_rf IN_LIST _rocm_real)
            continue()
        endif()
        list(APPEND _rocm_real "${_rf}")
        get_filename_component(_fn "${_f}" NAME)
        get_filename_component(_comp "${_f}" DIRECTORY)
        get_filename_component(_comp "${_comp}" NAME)
        # the per-GPU kernel packages' folders repeat their library's text
        if (_comp MATCHES "gfx[0-9]")
            continue()
        endif()
        file(COPY_FILE "${_f}" "${DEST}/licences/ROCm-${_comp}-${_fn}" ONLY_IF_DIFFERENT)
        math(EXPR _lic_count "${_lic_count} + 1")
    endforeach()
    # NVIDIA's licence for the toolkit (cudart / cuBLAS are redistributable
    # under its attachment A)
    foreach (_r ${ROOTS})
        if (_r MATCHES "cuda" AND EXISTS "${_r}/EULA.txt")
            file(COPY_FILE "${_r}/EULA.txt" "${DEST}/licences/CUDA-EULA.txt" ONLY_IF_DIFFERENT)
            math(EXPR _lic_count "${_lic_count} + 1")
            break()
        endif()
    endforeach()
    message(STATUS "whisper-dev: ${_lic_count} licence file(s) in ${DEST}/licences")
    if (_no_pkg)
        list(JOIN _no_pkg " " _no_pkg)
        message(WARNING "whisper-dev: no package (so no licence file) found for: ${_no_pkg}")
    endif()
elseif (_lic_names)
    message(WARNING "whisper-dev: dpkg not found - the bundled libraries' licence files were not collected "
        "(build in container-build/ to have them)")
endif()
