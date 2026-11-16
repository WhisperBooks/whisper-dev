#!/bin/sh
# Builds whisper-dev - or another repository with a build.sh, such as
# ffmpeg-dev - inside the Ubuntu 22.04 container of this folder, so the
# libraries run on any Linux with glibc 2.35 or newer. The repository is
# mounted, so dlls/ fills on the host as with a normal build; the build
# tree is build-container/ (never mixed with a host build's build/).
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
if ! ls "$HERE"/amdgpu-install_*.deb > /dev/null 2>&1; then
  echo "NOTE: no amdgpu-install_*.deb for Ubuntu 22.04 (jammy) in $HERE:"
  echo "      the image gets no ROCm, so whisper-dev builds no HIP backend"
fi
# the image (cached after the first time: several GB to download then)
"$DOCKER" build -t "$IMAGE" "$HERE"
TTY=
[ -t 1 ] && TTY=-t
# as the host user, so dlls/ and the build tree belong to you
exec "$DOCKER" run --rm $TTY -u "$(id -u):$(id -g)" -e HOME=/tmp -e JOBS \
  -e BUILD_DIR=build-container -e BUILD_ROOT=build-container \
  -v "$REPO:/src" -w /src "$IMAGE" sh ./build.sh "$@"
