# whisper-dev: given to the Windows HIP tree as CMAKE_PROJECT_INCLUDE (it
# is read at every project() of that tree; the main tree never sees it).
#
# 1. WHISPER_DEV_HIP_CMATH_SHIM (set by the main CMakeLists.txt when the
#    C++ library is Visual Studio 2026's, MSVC 14.51+): puts hip-msvc/ (a
#    <cmath> that declares clang's device math functions first) in front
#    of every include path. See hip-msvc/cmath for why.
# 2. Always: no -Wignored-attributes. Every HIP source is compiled once
#    for the PC and once per GPU target, and each GPU pass warns for every
#    function of ggml.h that "__declspec attribute 'dllimport' is not
#    supported" - hundreds of functions x the targets x 150 files, which
#    hid everything else in the log. The PC pass, the one that needs
#    dllimport, takes it.
if (WHISPER_DEV_HIP_CMATH_SHIM)
    include_directories(BEFORE "${CMAKE_CURRENT_LIST_DIR}/hip-msvc")
endif()
add_compile_options(-Wno-ignored-attributes)
