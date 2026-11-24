# CLAUDE.md - working rules for this repository

Read README.md and container-build/README.md first, then this file. Keep
all three up to date with every change. The rules are Epubunum's
(github.com/WhisperBooks/Epubunum, CLAUDE.md - same owner, same
conventions); where this file is silent, that one applies, and the
history of whisper-dev zips 01 - 20 is there (its session 7).

## Standing rules (owner)

- Never commit or push, and never offer to.
- Zips: only files changed since the previous zip, paths from the repo
  root, named whisper-dev-NN-topic.zip; numbers never reused; every
  delivery says what it goes on top of. No Delphi here: deliveries end
  with "NO PACKAGE REBUILD".
- No absolute paths, user names, machine names or e-mail addresses in
  tracked files - and none in the built libraries (BUILD-INFO.txt holds
  versions only; -ffile-prefix-map).
- README code blocks paste as-is: comments on their own line, no
  <placeholders>.
- Shell scripts need the executable bit in git (`git update-index
  --chmod=+x`); check after a push.
- whisper.cpp is a submodule pinned to a commit: never `--remote`.
- dlls/ is build output: only its .gitignore and README.md are tracked.

Last number used: 27.

## What can be tested without the SDKs

- Configure and the CPU build: `cmake -B <tmp> -DWHISPER_DEV_CUDA=OFF
  -DWHISPER_DEV_VULKAN=OFF -DWHISPER_DEV_HIP=OFF` (needs the submodule).
- cmake/clean_dlls.cmake on a scratch folder; cmake/bundle_linux.cmake
  with MODULES / ROOTS pointing at a scratch "SDK" (a small shared
  library and a module linking it) and a stand-in patchelf on PATH.
- `sh -n` on the scripts. Not testable without Docker and the SDKs: the
  image, CUDA / HIP compiles, real bundling - the owner's container build
  is their test.

## Zip 27 (on top of zip 26): the Windows HIP tree without the dllimport warnings
Owner, 2026-11-24 20:12: THE FIRST 1.9.6 WINDOWS BUILD IS THROUGH -
"[160/160] Linking CXX shared module bin\ggml-hip.dll ... Libraries
are in C:\src\whisper-dev\dlls" (CUDA toolkit 13.5 with CUDA_ALL,
Vulkan, HIP SDK 7.2 with Visual Studio 2026 / MSVC 14.51.36231). ZIPS
24, 25 AND 26 WORK ON WINDOWS (26's cmath: every HIP source compiled).
One hard system crash during the build before it (black screen,
restart; the owner: "quite possibly unrelated"; 26 compiles at once -
JOBS=8 was suggested, the next build ran through without).
Files: cmake/hip_msvc_cmath.cmake, CMakeLists.txt, CLAUDE.md.
- The HIP tree's log was unreadable ("a million errors whizzing past"):
  every GPU pass (six targets) warns for every GGML_API function that
  "__declspec attribute 'dllimport' is not supported
  [-Wignored-attributes]". Harmless (the PC pass takes dllimport) -
  owner: "after this build do that": add_compile_options(
  -Wno-ignored-attributes) in the HIP tree's project include, which is
  now given ALWAYS; the cmath folder only with
  -DWHISPER_DEV_HIP_CMATH_SHIM=ON (MSVC 14.51+ and
  WHISPER_DEV_HIP_CMATH, as before).
- NOT RUN (no Windows). The next build there configures the HIP tree
  again (new arguments) and compiles all of it once more.
- SEEN in that build: whisper.cpp 1.9.6 also builds parakeet.dll and
  parakeet-cli / -quantize (a second model's library). Not collected
  in dlls/, not used; could be left out of the build - NOT ASKED FOR.
- "Manually-specified variables were not used by the project:
  AMDGPU_TARGETS" in the HIP tree's configure: harmless (GPU_TARGETS
  is the one ROCm 7.2 reads; the compile lines carry the six
  --offload-arch).

## Zip 26 (on top of zip 25): Windows HIP compiles with Visual Studio 2026's library
Owner, 2026-11-24 19:33, the log of the second build: ZIP 25 WORKED (the
HIP tree configured), then every one of its HIP sources failed (418
errors, the first in binbcast.cu):
  ROCm\7.2\lib\clang\21\include\__clang_cuda_math_forward_declares.h:92:
  error: __device__ function 'isgreater' cannot overload __host__
  __device__ function 'isgreater'
  ...\MSVC\14.51.36231\include\cmath:688: note: previous declaration
(isgreater, isgreaterequal, isless, islessequal, islessgreater,
isunordered). Nothing else failed (CUDA 13.5's objects compiled).
NOT whisper.cpp 1.9.6 and not these scripts: Visual Studio 2026's
MSVC 14.51 library defines those functions constexpr for clang
(microsoft/STL#5717), the HIP SDK 7.2's clang 21 includes <cmath>
before its own device declarations. Known (searched): llama.cpp
#22570, llvm-project #201563 (clang to include the declarations
first), several projects with the same log.
Files: cmake/hip-msvc/cmath (new), cmake/hip_msvc_cmath.cmake (new),
CMakeLists.txt, README.md, CLAUDE.md.
- cmake/hip-msvc/cmath: in a HIP compile, clang's
  __clang_cuda_math_forward_declares.h, then #include_next <cmath> -
  the order llvm-project #201563 gives clang itself, and what another
  project's fix does (found by the search; its text says tested).
- The HIP tree gets it through -DCMAKE_PROJECT_INCLUDE=
  cmake/hip_msvc_cmath.cmake (include_directories(BEFORE ...)), ONLY
  when the main tree's compiler is cl 19.51+ (MSVC_VERSION >= 1951)
  and WHISPER_DEV_HIP_CMATH is ON (new option, ON).
- TESTED here, the mechanism only (clang 18, -x cuda, two system
  headers): constexpr isgreater then a device declaration of it - THE
  LOG'S ERROR, word for word; the device declaration first - compiles.
  The shim passes a plain C++ compile through.
- NOT RUN: no Windows, no HIP SDK here - the real build is the
  owner's. The Linux configure is unchanged. TO SEE on Windows: the
  configure line "the HIP tree gets cmake/hip-msvc/cmath"; the HIP
  tree's [n/160] steps pass binbcast.cu.
- IF IT DOES NOT COMPILE WITH IT: (1) MSVC 14.44 beside 14.51 (Visual
  Studio Installer, "MSVC v143 - VS 2022 C++ x64/x86 build tools
  (v14.44)") and the build from a prompt set up with
  vcvarsall.bat x64 -vcvars_ver=14.44 - reported to work by others;
  CUDA 13.5 is then compiled by that cl too. (2) build.bat
  -DWHISPER_DEV_HIP=OFF for everything but HIP.

## Zip 25 (on top of zip 24): the Windows HIP tree is told where the SDK is
Owner, 2026-11-24 19:18, the first 1.9.6 build on Windows (build/
deleted first, a new prompt after installing CUDA 13.5; CUDA's objects
compiled): the HIP tree's configure stopped at
ggml/src/ggml-hip/CMakeLists.txt:46 find_package(hip) - "Could not
find a package configuration file provided by hip". Files:
CMakeLists.txt, CLAUDE.md.
- ggml-hip's CMakeLists is THE SAME in 1.9.5 and 1.9.6: it adds
  ROCM_PATH (the environment's; /usr without) to CMAKE_PREFIX_PATH and
  nothing of HIP_PATH. So on Windows the package was found only
  through PATH (the SDK's bin there) or a hip_DIR remembered in
  build/hip's cache - GUESSED which; the deleted build/ and the new
  prompt are what changed.
- ExternalProject_Add(ggml-hip-windows): -DCMAKE_PREFIX_PATH=<HIP_PATH>
  (ggml appends to it). NOT RUN here.
- IF IT STILL FAILS: is <HIP_PATH>/lib/cmake/hip/hip-config.cmake
  there (an SDK update with another layout)? Then hip_DIR by hand.

## Zip 24 (on top of zip 23 = d7f76d6): build.bat passes CUDA_ALL=ON
Owner, 2026-11-24 19:00, building 1.9.6 on Windows with the CUDA
toolkit 13.5 (new that day): "is windows building cuda 7.5 or
7.5-virtual?" - it was 75-virtual (ggml's list with CUDA 13: 75-virtual
80-virtual 86-real 89-real 90-virtual 120a-real 121a-real; the same in
1.9.5) - "On linux we had to build 7.5 - not virtual - I'd prefer we
did the same here". Files: build.bat, README.md, CLAUDE.md.
- build.bat: -DCUDA_ALL=ON before the caller's arguments (so
  `build.bat -DCUDA_ALL=OFF` wins) - with CUDA 13+: 75;86;89;120, each
  as compiled code AND PTX (no suffix), as container-build/build.sh
  does since zip 17. 80, 90 and 121a are no longer named: those cards
  take the nearest lower one's.
- build.sh (a host build on Linux / macOS) is unchanged: OFF.
- NOT RUN here (no Windows, no CUDA). TO SEE: the configure prints
  ggml's "Replacing 120 in CMAKE_CUDA_ARCHITECTURES with 120a";
  ggml-cuda.dll is larger than before.
- A build folder made before this zip has no CUDA_ALL in its cache:
  the option on the command line sets it, no need to delete (the
  owner deleted build/ for 1.9.6 anyway).

## Zip 23 (on top of zip 22): whisper.cpp 1.9.6
Owner, 2026-11-24 (Epubunum session 15): "whisper 1.9.6 just came out",
then "OK, whisper-dev time". Files: CMakeLists.txt (a comment),
README.md, CLAUDE.md. THE SUBMODULE IS MOVED BY THE OWNER (never from
a zip): v1.9.6 = 96ec4d9823e9d0211944172da35f9f29134af990, from 5922450
(1.9.5-dev):
  git -C whisper.cpp fetch --tags origin
  git -C whisper.cpp checkout v1.9.6
  git add whisper.cpp
READ, 5922450 .. v1.9.6 (303 files):
- include/whisper.h: NO CHANGE. ggml-backend.h: NO CHANGE (what
  TWhisper binds beside whisper.h). ggml.h: only deprecated calls and
  three ops taken out (ggml_add1, ggml_diag_mask_*, ggml_rope_custom,
  ggml_upscale_ext ...) - nothing TWhisper or this build names.
- CMake: no option this file sets was renamed. ggml-cuda now links
  CUDA::cublasLt itself - already bundled here (Windows' copy list,
  Linux through bundle_linux.cmake).
- GGML IS 1.0.0 (was 0.29): THE SONAME CHANGES - libggml.so.1,
  libggml-base.so.1 (macOS: libggml.1.dylib, libggml-base.1.dylib),
  were .so.0 / .0.dylib. libwhisper stays .so.1. Nothing here names
  the number (the copies take the target's own soname; clean_dlls
  removes the .0 files of an earlier build from dlls/), BUT WHO TAKES
  dlls/ DOES: Epubunum (tools/steam_stage.py asks for libggml.so.0;
  the .dproj / .deployproj deployment lists name libggml.so.0,
  libggml-base.so.0, libggml.0.dylib, libggml-base.0.dylib; old .0
  files left in redistributable_bin) and TWhisper (its second name
  for ggml is '.so.0' - the first, libggml.so, is still there).
TESTED here (Linux x64, gcc 13, v1.9.6 in place of the submodule): the
configure with the GPU backends off ("ggml version: 1.0.0"), the dlls
target - 272 steps, libwhisper.so.1.9.6, libggml.so.1.0.0,
libggml-base.so.1.0.0, the fourteen CPU variants, libgomp.so.1;
BUILD-INFO.txt names the commit. NOT BUILT here: CUDA, Vulkan, HIP,
Windows, macOS / Core ML - the owner's builds are their test (CUDA:
the cublasLt link line is new; a toolkit without cublasLt would stop
at configure).

## Zip 22 (on top of zip 21): Core ML on macOS
Owner, 2026-11-18 (Epubunum session 9; M4 Mac mini, base.en Night Watch
55x on Metal): "can we have coreml for deployment when I build?"
- CMakeLists.txt: WHISPER_DEV_COREML (ON on APPLE, a FATAL_ERROR
  elsewhere) -> WHISPER_COREML and WHISPER_COREML_ALLOW_FALLBACK (a model
  without its -encoder.mlmodelc loads and runs on Metal instead of
  failing); whisper.coreml in the copied targets (libwhisper.coreml.dylib,
  linked by libwhisper; @loader_path as the others); the configure line
  and BUILD-INFO.txt say Core ML on Apple.
- README: the macOS Core ML row and paragraph; macOS backends are lib*.so
  (corrected - ggml's backend modules carry .so on every system but
  Windows).
TESTED here: configure on Linux unchanged (CPU only); -DWHISPER_DEV_COREML=ON
on Linux stops with the message. NOT BUILT on a Mac here. TO TEST on the
Mac: ./build.sh -> "Core ML encoder ON"; dlls/ has libwhisper.coreml.dylib;
otool -L dlls/libwhisper.dylib names @rpath/libwhisper.coreml.dylib (or
@loader_path); a model with its .mlmodelc logs "Core ML model loaded",
one without runs on Metal.
The encoders: huggingface.co/ggerganov/whisper.cpp, ggml-<name>-encoder.
mlmodelc.zip for tiny .. large-v3 and large-v3-turbo (EpubBuilder
downloads them with the models - Epubunum zip 102).

## Zip 21 (on top of 9fa21dc = zip 20): review fixes
A code review by reading of 9fa21dc (owner, 2026-11-16: "Do the same for
whisper-dev", then "y + claude.md"). Tested here: configure with the GPU
backends off (BUILD-INFO.txt written, the clean and copy commands in the
dlls target), libggml-base built (no build path in it), clean_dlls.cmake
and bundle_linux.cmake on scratch folders (stops without patchelf; with
a stand-in: bundled, ROCm licence text copied without a package).
NOT TESTED: Docker / Podman, CUDA and HIP compiles.
1. container-build/.dockerignore (new): only amdgpu-install_*.deb is in
   the image build's context. COPY . /ctx took the whole folder, so an
   edit to README.md, build.sh or a Dockerfile comment ran the ROCm
   install (several GB) and the dev-package step again.
2. cmake/clean_dlls.cmake (new), WHISPER_DEV_CLEAN_DLLS (on): the dlls
   target first removes the libraries, rocblas/, hipblaslt/, licences/
   and BUILD-INFO.txt of earlier builds from its folder. Nothing did: a
   backend turned off, an old soname, other HIP targets' kernels stayed
   and were shipped; and a runtime already in dlls/ was found first
   (libggml-cuda.so's $ORIGIN) and kept, so a toolkit update with the
   same soname left the old cuBLAS. dlls/BUILD-INFO.txt (written at
   configure time, copied by the target): time, system, glibc, compiler,
   whisper.cpp commit, backends, CUDA toolkit / architectures, HIP
   targets - a host build over a container build is now visible.
3. patchelf is required when runtimes are bundled: FATAL_ERROR at
   configure when it is missing, and in bundle_linux.cmake when it is
   missing or fails on a file (were warnings: a folder that works only
   where the SDKs are).
4. bundle_linux.cmake: NVIDIA's EULA and ROCm's share/doc licences are
   copied without dpkg (they were inside the dpkg branch); only the
   Debian copyright files need it.
5. -ffile-prefix-map also for HIP sources (clang) and CUDA sources
   (-Xcompiler=, as CMake passes -fPIC to nvcc). TO TEST first: the
   container build's first .cu file compiles; then `strings
   dlls/libggml-cuda.so dlls/libggml-hip.so | grep "$HOME"` prints
   nothing. If nvcc refuses the option, take the CUDA line out of
   add_compile_options (CMakeLists.txt, "source paths in assert
   messages").
6. container-build/build.sh: Podman is recognised by `--version`, not by
   the command's name (podman-docker's "docker" got -u uid:gid and the
   built files mapped ids).
Also: README's HIP default (ROCM_PATH or /opt/rocm), build.sh's comment
(container-build/build.sh), the garbled comment above the image build.
FOUND AND NOT FIXED (owner to decide):
- A HIP target that matches no kernel file is only counted in a status
  line: warn per target with none (a ROCm release naming kernels by
  family would leave a GPU without).
- patchelf changes NVIDIA's cudart / cuBLAS files: check the EULA's
  wording on redistribution of modified files; `patchelf --add-needed`
  of the transitive libraries on libggml-cuda.so would leave them as
  shipped.
- The image's downloads (CMake, patchelf, Vulkan SDK, amdgpu-install)
  have no checksums; VULKAN_SDK_VERSION=latest is not repeatable.
- container-build/build.sh: a mistyped repository path is taken as a
  CMake argument and whisper-dev is built.
- build.bat keeps CMakeCache.txt (build.sh deletes it: an option cached
  before an SDK was installed).
- bundle_linux.cmake: POST_EXCLUDE_REGEXES "^${DEST}/" - a path with
  regex characters (the printed list only).
- README "Benchmarks" names scripts/ and bench-*.bat, which are not in
  the repository; WHISPER_BUILD_EXAMPLES is ON for them. dlls/README.md
  is empty. No LICENSE file (public repository).
