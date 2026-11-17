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

Last number used: 21.

## What can be tested without the SDKs

- Configure and the CPU build: `cmake -B <tmp> -DWHISPER_DEV_CUDA=OFF
  -DWHISPER_DEV_VULKAN=OFF -DWHISPER_DEV_HIP=OFF` (needs the submodule).
- cmake/clean_dlls.cmake on a scratch folder; cmake/bundle_linux.cmake
  with MODULES / ROOTS pointing at a scratch "SDK" (a small shared
  library and a module linking it) and a stand-in patchelf on PATH.
- `sh -n` on the scripts. Not testable without Docker and the SDKs: the
  image, CUDA / HIP compiles, real bundling - the owner's container build
  is their test.

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
