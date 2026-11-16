#!/bin/sh
# Builds whisper-dev - or another repository with a build.sh, such as
# ffmpeg-dev - inside the Ubuntu 22.04 container of this folder, so the
# libraries run on any Linux with glibc 2.35 or newer. The repository is
# mounted at the SAME path as on the host, so dlls/ fills on the host as
# with a normal build and every absolute path a build records (FFmpeg's
# configured Makefile, CMake's cache, the logs) means the same inside and
# outside; the build tree is build-container/ (never mixed with a host
# build's build/).
#
#   container-build/build.sh                  whisper-dev
#   container-build/build.sh ../ffmpeg-dev    another repository
#
# Arguments after the repository go to its build.sh. DOCKER=podman uses
# Podman; JOBS=n limits the parallel compiles.
set -e
HERE=$(cd "$(dirname "$0")" && pwd)
REPO=$(cd "$HERE/.." && pwd)
if [ $# -gt 0 ] && [ -d "$1" ]; then
  REPO=$(cd "$1" && pwd)
  shift
fi
if [ ! -f "$REPO/build.sh" ]; then
  echo "No build.sh in $REPO"
  exit 1
fi
DOCKER=${DOCKER:-docker}
IMAGE=${IMAGE:-whisper-dev-build:ubuntu22.04}
if ! command -v "$DOCKER" > /dev/null 2>&1; then
  echo "$DOCKER is not installed: see container-build/README.md, \"Installing Docker or Podman\""
  exit 1
fi
# ROCm: the Dockerfile fetches AMD's amdgpu-install for Ubuntu 22.04 itself
# (AMDGPU_INSTALL_URL), or takes an amdgpu-install_*.deb put in this folder
# the image (cached after the first time: several GB to download then)
"$DOCKER" build -t "$IMAGE" "$HERE"
# whisper-dev only: the GPU SDKs must be in the image BEFORE an hour of
# compiling - a missing one stops here (ALLOW_MISSING=1 builds without it)
if [ "$REPO" = "$(cd "$HERE/.." && pwd)" ] && [ -z "$ALLOW_MISSING" ]; then
  MISSING=
  # ROCm: the compiler AND the HIP CMake package (ROCm 7.x installs them
  # separately, and without hip-lang CMake stops after the CUDA setup)
  "$DOCKER" run --rm "$IMAGE" sh -c 'test -x /opt/rocm/bin/hipconfig \
    && find -L /opt/rocm -maxdepth 6 -name hip-lang-config.cmake | grep -q .' \
    || MISSING="$MISSING ROCm(HIP-dev)"
  "$DOCKER" run --rm "$IMAGE" test -x /usr/local/cuda/bin/nvcc || MISSING="$MISSING CUDA"
  "$DOCKER" run --rm "$IMAGE" sh -c 'test -x "$VULKAN_SDK/bin/glslc"' || MISSING="$MISSING Vulkan"
  if [ -n "$MISSING" ]; then
    echo "The image lacks:$MISSING - nothing compiled. See the image build above"
    echo "(or build without them: ALLOW_MISSING=1 container-build/build.sh)."
    exit 1
  fi
  echo "Image has CUDA, Vulkan and ROCm."
fi
# whisper-dev: the build to ship has SASS for the usual GeForce cards
# (CUDA_ALL: 75;86;89;120). ggml's default list has only PTX for sm_75 and
# 80, which a driver older than the toolkit cannot compile ("the provided
# PTX was compiled with an unsupported toolchain" - ggml aborts the
# program). A -DCUDA_ALL=OFF given to this script comes later and wins.
WHISPER_ARGS=
[ "$REPO" = "$(cd "$HERE/.." && pwd)" ] && WHISPER_ARGS=-DCUDA_ALL=ON
TTY=
[ -t 1 ] && TTY=-t
# as the host user, so dlls/ and the build tree belong to you: Docker runs
# as your user and group ids; rootless Podman maps container ids to other
# ids on the host, so it keeps yours with --userns=keep-id instead
case $(basename "$DOCKER") in
  podman*) AS_USER="--userns=keep-id" ;;
  *) AS_USER="-u $(id -u):$(id -g)" ;;
esac
# shellcheck disable=SC2086
exec "$DOCKER" run --rm $TTY $AS_USER -e HOME=/tmp -e JOBS \
  -e BUILD_DIR=build-container -e BUILD_ROOT=build-container \
  -v "$REPO:$REPO:z" -w "$REPO" "$IMAGE" sh ./build.sh $WHISPER_ARGS "$@"
