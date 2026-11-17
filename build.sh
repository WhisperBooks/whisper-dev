#!/bin/sh
# whisper-dev: builds the whisper.cpp libraries and collects them in dlls/
# Extra arguments go to the configure step, e.g.
#   ./build.sh -DWHISPER_DEV_CUDA=OFF
# BUILD_DIR=folder builds there instead of build/ (container-build/build.sh
# uses build-container/, so the two trees never mix). Both collect in
# dlls/, each build emptying it of the one before: dlls/BUILD-INFO.txt
# says which build is there.
set -e
cd "$(dirname "$0")"
if [ ! -f whisper.cpp/include/whisper.h ]; then
  git submodule update --init --recursive
fi
BUILD_DIR=${BUILD_DIR:-build}

# what this machine offers, and why a backend will be missing - before an
# hour of compiling, not after (CMake decides the same way)
if [ "$(uname -s)" = Linux ]; then
  echo "whisper-dev on $(uname -s) $(uname -m), glibc $(ldd --version 2>/dev/null | head -n 1 | sed 's/.* //')"
  NVCC=$(command -v nvcc || true)
  [ -z "$NVCC" ] && [ -x /usr/local/cuda/bin/nvcc ] && NVCC=/usr/local/cuda/bin/nvcc
  if [ -n "$NVCC" ]; then
    echo "  CUDA:   $("$NVCC" --version | sed -n 's/.*release \([0-9.]*\).*/\1/p') ($NVCC)"
  else
    echo "  CUDA:   not found (no nvcc on PATH or in /usr/local/cuda/bin)"
  fi
  if [ -n "$VULKAN_SDK" ]; then
    echo "  Vulkan: SDK $VULKAN_SDK"
  elif command -v glslc > /dev/null 2>&1; then
    echo "  Vulkan: glslc $(command -v glslc) (distribution packages)"
  else
    echo "  Vulkan: not found (VULKAN_SDK not set: source the LunarG SDK's setup-env.sh; no glslc on PATH)"
  fi
  ROCM=${ROCM_PATH:-/opt/rocm}
  if [ -x "$ROCM/bin/hipconfig" ]; then
    echo "  HIP:    ROCm $("$ROCM/bin/hipconfig" --version 2>/dev/null | head -n 1) ($ROCM)"
  else
    echo "  HIP:    not found (no $ROCM/bin/hipconfig - ROCm not installed, or set ROCM_PATH)"
  fi
  if command -v patchelf > /dev/null 2>&1; then
    echo "  patchelf: $(command -v patchelf)"
  else
    echo "  patchelf: not found (needed to bundle the CUDA / ROCm runtimes: with CUDA or ROCm"
    echo "            here the configure step stops - install it, or -DWHISPER_DEV_BUNDLE_RUNTIMES=OFF)"
  fi
fi

# configured afresh every time: CMake keeps an option it once stored
# (WHISPER_DEV_HIP=OFF from a run before ROCm was installed) even when the
# SDK is there now. Only the cache goes - compiled objects are reused.
rm -f "$BUILD_DIR/CMakeCache.txt"
cmake -B "$BUILD_DIR" -DCMAKE_BUILD_TYPE=Release "$@"
# "-j" alone means unlimited jobs with make and can exhaust memory: one per CPU
cmake --build "$BUILD_DIR" --config Release -j "${JOBS:-$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 4)}"
echo
echo "Libraries are in $(pwd)/dlls"
