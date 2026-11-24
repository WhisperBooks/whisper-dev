# whisper-dev - builds the whisper.cpp shared libraries TWhisper loads, with
# every backend as its own library (GGML_BACKEND_DL), and collects them in
# <repo>/dlls (Debug builds: <repo>/dlls/debug).
#
#   build.bat     Windows: sets up the x64 Visual Studio environment itself and
#                 uses the Ninja Multi-Config generator (as whisper.cpp's own
#                 release builds do: the Visual Studio generator needs NVIDIA's
#                 MSBuild integration for CUDA, which may be missing for the
#                 installed Visual Studio - "No CUDA toolset found")
#   ./build.sh    Linux / macOS
# Options (cmake -D...):
#   WHISPER_DEV_CUDA      CUDA backend          Windows: ON (required), else: ON if nvcc found
#   WHISPER_DEV_VULKAN    Vulkan backend        Windows: ON (required), else: ON if VULKAN_SDK set
#   WHISPER_DEV_HIP       AMD HIP backend       ON if HIP_PATH (Windows) / ROCM_PATH or /opt/rocm (Linux)
#   WHISPER_DEV_HIP_TARGETS  AMD GPU architectures, e.g. "gfx1100;gfx1201"
#   WHISPER_DEV_BLAS      OpenBLAS backend      OFF (see below)
#   WHISPER_DEV_OPENVINO  OpenVINO encoder      OFF (see below)
#   WHISPER_DEV_COREML    Core ML encoder       macOS: ON (see below), else not available
#   CUDA_ALL              CUDA archs 50;75;86;89;120 instead of ggml's default list
#                         (75;86;89;120 with CUDA 13+, which has no sm_50)
#   WHISPER_DEV_BUNDLE_RUNTIMES  Linux: CUDA / ROCm runtimes into dlls/  ON
#   WHISPER_DEV_CLEAN_DLLS  empty dlls/ of earlier builds' libraries first  ON
#
# The CPU backend is always built in every variant the platform supports
# (GGML_CPU_ALL_VARIANTS); ggml picks the best one for the machine at run
# time. GPU backends whose runtime is missing on a machine are skipped there.
# Missing SDKs for a required backend stop the configure step with a message
# instead of silently building less.
#
# Core ML (macOS): the encoder runs through Apple's Core ML (Neural Engine /
# GPU), the decoder on Metal. whisper.coreml is a library of its own
# (libwhisper.coreml.dylib, collected in dlls/); a model uses Core ML only
# when its ggml-<name>-encoder.mlmodelc folder is beside the .bin - with
# WHISPER_COREML_ALLOW_FALLBACK (always set here) a model without one runs
# on Metal as before instead of failing to load. The first load of an
# encoder on a machine is slow (macOS compiles it for the device).
#
# BLAS is off by default: whisper.cpp ALWAYS uses an accelerator backend
# that is present, so a ggml-blas library in the folder would take the
# choice away from the program. OpenVINO is off by default: it links into
# whisper itself, which then does not load at all where OpenVINO is missing.

cmake_minimum_required(VERSION 3.21)
project(whisper-dev C CXX)

if (POLICY CMP0077)
    cmake_policy(SET CMP0077 NEW)   # option() honours normal variables set here
endif()
# whisper.cpp starts with cmake_minimum_required(VERSION 3.5), which resets
# CMP0077 to OLD in its scope: its option() calls would then DISCARD the values
# set below (BUILD_SHARED_LIBS, WHISPER_BUILD_EXAMPLES, ...) and use their own
# defaults. Make NEW the default for policies the subproject leaves unset.
set(CMAKE_POLICY_DEFAULT_CMP0077 NEW)

set(WHISPER_SRC ${CMAKE_CURRENT_SOURCE_DIR}/whisper.cpp)
if (NOT EXISTS ${WHISPER_SRC}/include/whisper.h)
    message(FATAL_ERROR "whisper.cpp submodule missing: git submodule update --init --recursive")
endif()

set(DLL_DIR ${CMAKE_CURRENT_SOURCE_DIR}/dlls)

message(STATUS "whisper-dev: ${CMAKE_SYSTEM_NAME} ${CMAKE_SYSTEM_PROCESSOR}, output ${DLL_DIR}")

# ---------------------------------------------------------------- defaults
set(_cuda_default OFF)
set(_vulkan_default OFF)
set(_hip_default OFF)
if (WIN32)
    set(_cuda_default ON)
    set(_vulkan_default ON)
    if (DEFINED ENV{HIP_PATH})
        set(_hip_default ON)
    endif()
elseif (CMAKE_SYSTEM_NAME MATCHES "Linux")
    find_program(_nvcc nvcc HINTS /usr/local/cuda/bin)
    if (_nvcc)
        set(_cuda_default ON)
        set(CMAKE_CUDA_COMPILER ${_nvcc})
    endif()
    find_program(_glslc glslc)
    if (DEFINED ENV{VULKAN_SDK} OR _glslc)
        set(_vulkan_default ON)
    endif()
    # ROCm: ROCM_PATH, else where AMD's packages put it (ggml-hip looks
    # there too) - a forgotten export no longer leaves HIP out silently
    if (DEFINED ENV{ROCM_PATH} OR EXISTS /opt/rocm/bin/hipconfig)
        set(_hip_default ON)
    endif()
endif()

option(WHISPER_DEV_CUDA     "Build the CUDA backend"   ${_cuda_default})
option(WHISPER_DEV_VULKAN   "Build the Vulkan backend" ${_vulkan_default})
option(WHISPER_DEV_HIP      "Build the AMD HIP backend" ${_hip_default})
option(WHISPER_DEV_BLAS     "Build the OpenBLAS backend (always used when present)" OFF)
option(WHISPER_DEV_OPENVINO "Build whisper with the OpenVINO encoder (needs OpenVINO at run time)" OFF)
if (APPLE)
    set(_coreml_default ON)
else()
    set(_coreml_default OFF)
endif()
option(WHISPER_DEV_COREML   "macOS: build whisper with the Core ML encoder (falls back to Metal without an .mlmodelc)" ${_coreml_default})
option(CUDA_ALL             "CUDA architectures 50;75;86;89;120 instead of ggml's default" OFF)
option(WHISPER_DEV_BUNDLE_RUNTIMES "Linux: copy the CUDA / ROCm runtime libraries the GPU backends need into dlls/" ON)
option(WHISPER_DEV_CLEAN_DLLS "Remove the libraries of earlier builds from dlls/ before collecting this build's" ON)
set(WHISPER_DEV_HIP_TARGETS "gfx1030;gfx1100;gfx1101;gfx1102;gfx1200;gfx1201" CACHE STRING
    "AMD GPU architectures for HIP (only ones the HIP SDK has rocBLAS kernels for)")

# ---------------------------------------------------------------- SDK checks
if (WHISPER_DEV_COREML AND NOT APPLE)
    message(FATAL_ERROR "Core ML is macOS only: configure with -DWHISPER_DEV_COREML=OFF")
endif()
if (WHISPER_DEV_CUDA AND WIN32 AND NOT DEFINED ENV{CUDA_PATH})
    message(FATAL_ERROR "CUDA_PATH is not set: install the CUDA Toolkit or configure with -DWHISPER_DEV_CUDA=OFF")
endif()
if (WHISPER_DEV_VULKAN AND WIN32 AND NOT DEFINED ENV{VULKAN_SDK})
    message(FATAL_ERROR "VULKAN_SDK is not set: install the Vulkan SDK or configure with -DWHISPER_DEV_VULKAN=OFF")
endif()
# Linux: the Vulkan SDK is optional - the distribution's packages do
# (Ubuntu / Debian: libvulkan-dev glslc spirv-headers;
#  Arch: vulkan-headers vulkan-icd-loader shaderc spirv-headers)
if (WHISPER_DEV_VULKAN AND NOT WIN32 AND NOT APPLE AND NOT DEFINED ENV{VULKAN_SDK})
    find_package(Vulkan)
    find_package(SPIRV-Headers CONFIG QUIET)
    if (NOT Vulkan_FOUND OR NOT Vulkan_GLSLC_EXECUTABLE OR NOT SPIRV-Headers_FOUND)
        message(FATAL_ERROR "Vulkan headers / glslc / SPIRV-Headers not found: install the Vulkan SDK or your distribution's packages (Ubuntu: libvulkan-dev glslc spirv-headers), or configure with -DWHISPER_DEV_VULKAN=OFF")
    endif()
endif()

# ---------------------------------------------------------------- whisper.cpp
set(BUILD_SHARED_LIBS        ON)
set(GGML_BACKEND_DL          ON)
set(GGML_NATIVE              OFF)    # portable: runs on any CPU of the architecture
set(WHISPER_BUILD_TESTS      OFF)
set(WHISPER_BUILD_EXAMPLES   ON)     # whisper-cli / whisper-bench for the bench scripts
set(WHISPER_SDL2             OFF)
set(GGML_CUDA   ${WHISPER_DEV_CUDA})
set(GGML_VULKAN ${WHISPER_DEV_VULKAN})
set(GGML_BLAS   ${WHISPER_DEV_BLAS})
set(WHISPER_OPENVINO ${WHISPER_DEV_OPENVINO})
# Core ML with the fallback: a model without its -encoder.mlmodelc still
# loads (on Metal)
set(WHISPER_COREML ${WHISPER_DEV_COREML})
set(WHISPER_COREML_ALLOW_FALLBACK ${WHISPER_DEV_COREML})
if (WHISPER_DEV_BLAS AND NOT GGML_BLAS_VENDOR)
    set(GGML_BLAS_VENDOR "OpenBLAS")
endif()

# every CPU variant where ggml supports it (x86 everywhere; ARM on Linux,
# Android and macOS - not Windows on ARM)
if (CMAKE_SYSTEM_PROCESSOR MATCHES "^(x86_64|AMD64|amd64|i.86)$" OR
    (CMAKE_SYSTEM_PROCESSOR MATCHES "^(aarch64|arm64|ARM64)$" AND NOT WIN32))
    set(GGML_CPU_ALL_VARIANTS ON)
else()
    set(GGML_CPU_ALL_VARIANTS OFF)
endif()

if (WHISPER_DEV_CUDA)
    # nvcc refuses host compilers newer than the CUDA release knows (Visual
    # Studio 2026 = MSVC 19.50+ with an older toolkit); this only skips that
    # version check.
    if (MSVC AND MSVC_VERSION GREATER_EQUAL 1950 AND NOT CMAKE_CUDA_FLAGS MATCHES "allow-unsupported-compiler")
        set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} -allow-unsupported-compiler")
        message(STATUS "whisper-dev: MSVC ${MSVC_VERSION} - passing -allow-unsupported-compiler to nvcc")
    endif()
    # the toolkit's version (for CUDA_ALL below and dlls/BUILD-INFO.txt)
    set(_nvcc_ver "")
    set(_nvcc_release "")
    set(_nvcc_exe "${CMAKE_CUDA_COMPILER}")
    if (NOT _nvcc_exe AND DEFINED ENV{CUDA_PATH})
        set(_nvcc_exe "$ENV{CUDA_PATH}/bin/nvcc")
    endif()
    if (_nvcc_exe)
        execute_process(COMMAND "${_nvcc_exe}" --version OUTPUT_VARIABLE _nvcc_out ERROR_QUIET)
        if (_nvcc_out MATCHES "release ([0-9]+)\\.([0-9]+)")
            set(_nvcc_ver "${CMAKE_MATCH_1}")
            set(_nvcc_release "${CMAKE_MATCH_1}.${CMAKE_MATCH_2}")
        endif()
    endif()
    if (CUDA_ALL)
        # CUDA 13 dropped Maxwell / Pascal / Volta (sm_50 - sm_72): 50 only
        # with an older toolkit (ggml's own default list does the same)
        if (_nvcc_ver AND _nvcc_ver GREATER_EQUAL 13)
            set(CMAKE_CUDA_ARCHITECTURES "75;86;89;120")
        else()
            set(CMAKE_CUDA_ARCHITECTURES "50;75;86;89;120")
        endif()
    elseif (CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64" AND NOT DEFINED CMAKE_CUDA_ARCHITECTURES)
        set(CMAKE_CUDA_ARCHITECTURES "87")   # Jetson Orin
    endif()
endif()

# HIP: on Linux in this tree; on Windows in a separate clang tree (below),
# because the HIP SDK's clang cannot share a tree with MSVC (needed by CUDA).
if (WHISPER_DEV_HIP AND NOT WIN32)
    set(GGML_HIP ON)
    set(AMDGPU_TARGETS ${WHISPER_DEV_HIP_TARGETS})
    set(GPU_TARGETS ${WHISPER_DEV_HIP_TARGETS})
    # CMake takes the ROCm root from the HIP compiler's folder. In ROCm 7.x
    # the compiler sits in its own part (/opt/rocm/core-NN/lib/llvm), which
    # has no hip-lang package, so enable_language(HIP) fails. Find the folder
    # that does have it and tell CMake (and find_package) where it is.
    if (NOT CMAKE_HIP_COMPILER_ROCM_ROOT)
        if (DEFINED ENV{ROCM_PATH})
            set(_rocm "$ENV{ROCM_PATH}")
        else()
            set(_rocm "/opt/rocm")
        endif()
        file(GLOB _hip_lang
            "${_rocm}/lib/cmake/hip-lang/hip-lang-config.cmake"
            "${_rocm}/lib64/cmake/hip-lang/hip-lang-config.cmake"
            "${_rocm}/*/lib/cmake/hip-lang/hip-lang-config.cmake"
            "${_rocm}/*/lib64/cmake/hip-lang/hip-lang-config.cmake")
        if (_hip_lang)
            list(GET _hip_lang 0 _hip_lang)
            # <root>/lib/cmake/hip-lang/hip-lang-config.cmake -> <root>
            get_filename_component(_hip_root "${_hip_lang}" DIRECTORY)
            get_filename_component(_hip_root "${_hip_root}" DIRECTORY)
            get_filename_component(_hip_root "${_hip_root}" DIRECTORY)
            get_filename_component(_hip_root "${_hip_root}" DIRECTORY)
            set(CMAKE_HIP_COMPILER_ROCM_ROOT "${_hip_root}" CACHE PATH "ROCm folder with the hip-lang CMake package")
            list(APPEND CMAKE_PREFIX_PATH "${_hip_root}" "${_rocm}")
            message(STATUS "whisper-dev: ROCm root for HIP ${_hip_root}")
        else()
            message(WARNING "whisper-dev: no hip-lang-config.cmake under ${_rocm} - "
                "if HIP fails to configure, pass -DCMAKE_HIP_COMPILER_ROCM_ROOT=<ROCm folder>")
        endif()
    endif()
endif()

# Linux / macOS: the libraries find each other in their OWN folder ($ORIGIN /
# @loader_path, as ffmpeg-dev's do), not through the build tree's absolute
# path (the default RUNPATH: the folder dlls/ is copied to had no say, and
# the build machine's path was in every library). The programs in
# <build>/bin find the libraries there the same way.
if (NOT WIN32)
    set(CMAKE_BUILD_WITH_INSTALL_RPATH ON)
    if (APPLE)
        set(CMAKE_INSTALL_RPATH "@loader_path")
    else()
        set(CMAKE_INSTALL_RPATH "$ORIGIN")
    endif()
    # source paths in assert messages as whisper.cpp/..., not the build
    # machine's - in the GPU backends too (the container mounts the
    # repository at its host path, so libggml-cuda.so / libggml-hip.so
    # carried the builder's folder). HIP sources are compiled by clang,
    # which takes the option as it is; nvcc hands it to the host compiler
    # (-Xcompiler=, as CMake does for -fPIC), which also preprocesses.
    # Check: strings dlls/libggml-cuda.so | grep "$HOME" prints nothing.
    add_compile_options(
        "$<$<COMPILE_LANGUAGE:C,CXX,HIP>:-ffile-prefix-map=${WHISPER_SRC}/=whisper.cpp/>"
        "$<$<COMPILE_LANGUAGE:CUDA>:-Xcompiler=-ffile-prefix-map=${WHISPER_SRC}/=whisper.cpp/>")
endif()

add_subdirectory(${WHISPER_SRC} whisper.cpp)

# ---------------------------------------------------------------- collect
# whisper.cpp writes its libraries to <build>/bin whatever a parent sets, so
# the 'dlls' target copies them (and the runtimes they need) to DLL_DIR.
set(_dest "$<IF:$<CONFIG:Debug>,${DLL_DIR}/debug,${DLL_DIR}>")
set(_copy_cmds)
# first out with what earlier builds left there: a backend since turned
# off, runtimes under an older soname, kernels of GPUs no longer targeted -
# ggml loads every backend in the folder and the folder is what gets
# shipped. It also makes the bundler take the runtimes from the SDK again
# (a copy already in dlls/ was found first and kept: a toolkit update with
# the same soname left the old cuBLAS beside the new backend).
if (WHISPER_DEV_CLEAN_DLLS)
    list(APPEND _copy_cmds COMMAND ${CMAKE_COMMAND} "-DDEST=${_dest}"
        -P ${CMAKE_CURRENT_SOURCE_DIR}/cmake/clean_dlls.cmake)
endif()
list(APPEND _copy_cmds COMMAND ${CMAKE_COMMAND} -E make_directory ${_dest})
set(_copy_deps)

# shared libraries: the file, plus on Linux / macOS the soname and the plain
# name (libggml.so.1 is what the others NEED - .so.0 before ggml 1.0, that
# is up to whisper.cpp 1.9.5; libggml.so is what TWhisper looks for first)
# (whisper.coreml: macOS with WHISPER_DEV_COREML - libwhisper needs it)
foreach (_t whisper ggml ggml-base whisper.coreml)
    if (TARGET ${_t})
        list(APPEND _copy_deps ${_t})
        list(APPEND _copy_cmds COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:${_t}> ${_dest})
        if (NOT WIN32)
            list(APPEND _copy_cmds
                COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:${_t}> ${_dest}/$<TARGET_SONAME_FILE_NAME:${_t}>
                COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:${_t}> ${_dest}/$<TARGET_LINKER_FILE_NAME:${_t}>)
        endif()
    endif()
endforeach()

# backend modules (every CPU variant, CUDA, Vulkan, Metal, HIP, BLAS, ...)
foreach (_t ${GGML_AVAILABLE_BACKENDS})
    if (TARGET ${_t})
        list(APPEND _copy_deps ${_t})
        list(APPEND _copy_cmds COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:${_t}> ${_dest})
    endif()
endforeach()

# Linux with gcc: OpenMP's runtime (libgomp.so.1, which every ggml-cpu
# variant NEEDS) next to the libraries, as vcomp140.dll on Windows - Steam's
# Linux runtime and minimal systems may not have it. Found through $ORIGIN.
if (CMAKE_SYSTEM_NAME MATCHES "Linux" AND CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    execute_process(COMMAND ${CMAKE_CXX_COMPILER} -print-file-name=libgomp.so.1
        OUTPUT_VARIABLE _gomp OUTPUT_STRIP_TRAILING_WHITESPACE)
    if (_gomp AND EXISTS "${_gomp}" AND IS_ABSOLUTE "${_gomp}")
        get_filename_component(_gomp "${_gomp}" REALPATH)
        list(APPEND _copy_cmds COMMAND ${CMAKE_COMMAND} -E copy_if_different ${_gomp} ${_dest}/libgomp.so.1)
    endif()
endif()

# Linux: the GPU backends' runtimes (CUDA: cudart, cuBLAS, cuBLASLt; ROCm:
# amdhip64, hipBLAS, rocBLAS + kernels, HSA, ...) copied into dlls/ with
# RUNPATH $ORIGIN, so one build runs on Linux systems without the SDKs (as
# on Windows; the drivers are the system's). cmake/bundle_linux.cmake.
if (CMAKE_SYSTEM_NAME MATCHES "Linux" AND WHISPER_DEV_BUNDLE_RUNTIMES AND (WHISPER_DEV_CUDA OR WHISPER_DEV_HIP))
    set(_roots)
    if (WHISPER_DEV_CUDA)
        set(_nvcc_path "${CMAKE_CUDA_COMPILER}")
        if (NOT _nvcc_path)
            set(_nvcc_path "${_nvcc}")
        endif()
        if (_nvcc_path)
            get_filename_component(_cuda_root "${_nvcc_path}" REALPATH)
            get_filename_component(_cuda_root "${_cuda_root}" DIRECTORY)
            get_filename_component(_cuda_root "${_cuda_root}" DIRECTORY)
            list(APPEND _roots "${_cuda_root}")
        endif()
    endif()
    if (WHISPER_DEV_HIP)
        if (DEFINED ENV{ROCM_PATH})
            list(APPEND _roots "$ENV{ROCM_PATH}")
        else()
            list(APPEND _roots "/opt/rocm")
        endif()
    endif()
    string(REPLACE ";" "|" _roots_arg "${_roots}")
    string(REPLACE ";" "|" _targets_arg "${WHISPER_DEV_HIP_TARGETS}")
    list(APPEND _copy_cmds COMMAND ${CMAKE_COMMAND} "-DDEST=${_dest}" "-DROOTS=${_roots_arg}"
        "-DHIP_TARGETS=${_targets_arg}" -P ${CMAKE_CURRENT_SOURCE_DIR}/cmake/bundle_linux.cmake)
    # without patchelf the folder looks complete and fails only on a system
    # without the SDKs (libggml-hip.so has no RUNPATH, the runtimes do not
    # find each other): stop now, not after an hour of compiling
    find_program(_patchelf_check patchelf)
    if (NOT _patchelf_check)
        message(FATAL_ERROR "patchelf not found: the bundled CUDA / ROCm libraries cannot be given RUNPATH "
            "$ORIGIN. Install it (distribution package, or github.com/NixOS/patchelf), or configure with "
            "-DWHISPER_DEV_BUNDLE_RUNTIMES=OFF (a folder for systems that have the SDKs installed)")
    endif()
endif()

if (WIN32)
    # CUDA runtime next to ggml-cuda.dll (CUDA 13 keeps it in bin\x64)
    if (WHISPER_DEV_CUDA)
        file(GLOB _cuda_dlls
            "$ENV{CUDA_PATH}/bin/cudart64_*.dll" "$ENV{CUDA_PATH}/bin/cublas64_*.dll" "$ENV{CUDA_PATH}/bin/cublasLt64_*.dll"
            "$ENV{CUDA_PATH}/bin/x64/cudart64_*.dll" "$ENV{CUDA_PATH}/bin/x64/cublas64_*.dll" "$ENV{CUDA_PATH}/bin/x64/cublasLt64_*.dll")
        if (NOT _cuda_dlls)
            message(FATAL_ERROR "No cudart64_*.dll / cublas64_*.dll under $ENV{CUDA_PATH}/bin")
        endif()
        list(APPEND _copy_cmds COMMAND ${CMAKE_COMMAND} -E copy_if_different ${_cuda_dlls} ${_dest})
    endif()
    # MSVC runtime + OpenMP (vcomp140.dll, used by ggml-cpu): app-local, so
    # the folder works where the VC++ redistributable is not installed
    set(CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS_SKIP ON)
    set(CMAKE_INSTALL_OPENMP_LIBRARIES ON)
    set(CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS_NO_WARNINGS ON)
    include(InstallRequiredSystemLibraries)
    if (CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS)
        list(APPEND _copy_cmds COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS} ${_dest})
    endif()
    # OpenBLAS from vcpkg
    if (WHISPER_DEV_BLAS AND DEFINED VCPKG_INSTALLED_DIR)
        file(GLOB _blas_dlls "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/bin/*.dll")
        if (_blas_dlls)
            list(APPEND _copy_cmds COMMAND ${CMAKE_COMMAND} -E copy_if_different ${_blas_dlls} ${_dest})
        endif()
    endif()
endif()

# what this folder is: where and from what it was built (a host build
# over a container build's dlls/ looks the same but needs the host's
# glibc). Versions only - no path, user or machine name.
set(_info "whisper-dev libraries\n")
string(TIMESTAMP _now "%Y-%m-%d %H:%M UTC" UTC)
string(APPEND _info "Configured: ${_now}\n")
string(APPEND _info "System: ${CMAKE_SYSTEM_NAME} ${CMAKE_SYSTEM_PROCESSOR}")
if (CMAKE_SYSTEM_NAME MATCHES "Linux")
    execute_process(COMMAND getconf GNU_LIBC_VERSION OUTPUT_VARIABLE _glibc
        OUTPUT_STRIP_TRAILING_WHITESPACE ERROR_QUIET)
    if (_glibc)
        string(APPEND _info ", built against ${_glibc} (a system with an older one may not load them)")
    endif()
endif()
string(APPEND _info "\nCompiler: ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}\n")
find_package(Git QUIET)
if (GIT_FOUND)
    execute_process(COMMAND ${GIT_EXECUTABLE} -C ${WHISPER_SRC} rev-parse HEAD OUTPUT_VARIABLE _wcommit
        OUTPUT_STRIP_TRAILING_WHITESPACE ERROR_QUIET)
    if (_wcommit)
        string(APPEND _info "whisper.cpp: ${_wcommit}\n")
    endif()
endif()
string(APPEND _info "CPU: all variants ${GGML_CPU_ALL_VARIANTS}\n")
if (WHISPER_DEV_CUDA)
    if (CMAKE_CUDA_ARCHITECTURES)
        set(_archs "${CMAKE_CUDA_ARCHITECTURES}")
    else()
        set(_archs "ggml's default list")
    endif()
    string(APPEND _info "CUDA: toolkit ${_nvcc_release}, architectures ${_archs}\n")
else()
    string(APPEND _info "CUDA: not built\n")
endif()
string(APPEND _info "Vulkan: ${WHISPER_DEV_VULKAN}\n")
if (WHISPER_DEV_HIP)
    string(APPEND _info "HIP: targets ${WHISPER_DEV_HIP_TARGETS}\n")
else()
    string(APPEND _info "HIP: not built\n")
endif()
string(APPEND _info "BLAS: ${WHISPER_DEV_BLAS}, OpenVINO: ${WHISPER_DEV_OPENVINO}\n")
if (APPLE)
    string(APPEND _info "Core ML: ${WHISPER_DEV_COREML} (with the fallback to Metal)\n")
endif()
if (CMAKE_SYSTEM_NAME MATCHES "Linux")
    string(APPEND _info "GPU runtimes bundled: ${WHISPER_DEV_BUNDLE_RUNTIMES}\n")
endif()
file(WRITE ${CMAKE_BINARY_DIR}/BUILD-INFO.txt "${_info}")
list(APPEND _copy_cmds COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_BINARY_DIR}/BUILD-INFO.txt ${_dest})

add_custom_target(dlls ALL ${_copy_cmds}
    COMMENT "Collecting the whisper.cpp libraries in ${DLL_DIR}"
    VERBATIM)
add_dependencies(dlls ${_copy_deps})

# ---------------------------------------------------------------- HIP (Windows)
if (WHISPER_DEV_HIP AND WIN32)
    if (NOT DEFINED ENV{HIP_PATH})
        message(FATAL_ERROR "HIP_PATH is not set: install the AMD HIP SDK or configure with -DWHISPER_DEV_HIP=OFF")
    endif()
    file(TO_CMAKE_PATH "$ENV{HIP_PATH}" _hip)
    find_program(_ninja ninja)
    if (NOT _ninja)
        message(FATAL_ERROR "ninja is not on PATH (needed to build the HIP backend)")
    endif()
    find_program(_hip_clang clang PATHS ${_hip}/bin ${_hip}/lib/llvm/bin NO_DEFAULT_PATH)
    find_program(_hip_clangxx clang++ PATHS ${_hip}/bin ${_hip}/lib/llvm/bin NO_DEFAULT_PATH)
    if (NOT _hip_clang OR NOT _hip_clangxx)
        message(FATAL_ERROR "clang / clang++ not found in the HIP SDK at ${_hip}")
    endif()
    string(REPLACE ";" "|" _hip_targets "${WHISPER_DEV_HIP_TARGETS}")
    include(ExternalProject)
    # Same checkout, its own tree, only ggml-hip is built; at run time it uses
    # the MSVC-built ggml-base.dll of the main tree (same backend API version).
    ExternalProject_Add(ggml-hip-windows
        SOURCE_DIR ${WHISPER_SRC}
        BINARY_DIR ${CMAKE_BINARY_DIR}/hip
        CMAKE_GENERATOR Ninja
        LIST_SEPARATOR |
        CMAKE_ARGS
            -DCMAKE_MAKE_PROGRAM=${_ninja}
            -DCMAKE_C_COMPILER=${_hip_clang}
            -DCMAKE_CXX_COMPILER=${_hip_clangxx}
            -DCMAKE_BUILD_TYPE=Release
            -DBUILD_SHARED_LIBS=ON -DGGML_BACKEND_DL=ON -DGGML_NATIVE=OFF -DGGML_CPU=OFF
            -DGGML_HIP=ON -DAMDGPU_TARGETS=${_hip_targets} -DGPU_TARGETS=${_hip_targets}
            -DWHISPER_BUILD_EXAMPLES=OFF -DWHISPER_BUILD_TESTS=OFF -DWHISPER_SDL2=OFF
        BUILD_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --target ggml-hip
        BUILD_ALWAYS ON
        INSTALL_COMMAND "")
    # ggml-hip.dll + hipBLAS / rocBLAS and their kernel libraries
    # (amdhip64_*.dll comes with the AMD driver and is not copied)
    file(GLOB _hip_dlls "${_hip}/bin/hipblas.dll" "${_hip}/bin/hipblaslt.dll" "${_hip}/bin/rocblas.dll")
    set(_hip_cmds
        COMMAND ${CMAKE_COMMAND} -E make_directory ${DLL_DIR}
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_BINARY_DIR}/hip/bin/ggml-hip.dll ${DLL_DIR})
    if (_hip_dlls)
        list(APPEND _hip_cmds COMMAND ${CMAKE_COMMAND} -E copy_if_different ${_hip_dlls} ${DLL_DIR})
    endif()
    foreach (_lib rocblas hipblaslt)
        if (EXISTS ${_hip}/bin/${_lib}/library)
            list(APPEND _hip_cmds COMMAND ${CMAKE_COMMAND} -E copy_directory
                ${_hip}/bin/${_lib}/library ${DLL_DIR}/${_lib}/library)
        endif()
    endforeach()
    add_custom_target(dlls-hip ALL ${_hip_cmds}
        COMMENT "Collecting the HIP backend in ${DLL_DIR}"
        VERBATIM)
    add_dependencies(dlls-hip ggml-hip-windows dlls)
endif()

# ---------------------------------------------------------------- summary
message(STATUS "whisper-dev backends: CPU (all variants: ${GGML_CPU_ALL_VARIANTS}), CUDA ${WHISPER_DEV_CUDA}, "
               "Vulkan ${WHISPER_DEV_VULKAN}, HIP ${WHISPER_DEV_HIP}, BLAS ${WHISPER_DEV_BLAS}, "
               "OpenVINO ${WHISPER_DEV_OPENVINO}")
if (APPLE)
    message(STATUS "whisper-dev: Metal built in; Core ML encoder ${WHISPER_DEV_COREML} (fallback to Metal)")
endif()
