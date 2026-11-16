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
if ! ls "$HERE"/amdgpu-install_*.deb > /dev/null 2>&1; then
  echo "NOTE: no amdgpu-install_*.deb for Ubuntu 22.04 (jammy) in $HERE:"
  echo "      the image gets no ROCm, so whisper-dev builds no HIP backend"
fi
# the image (cached after the first time: several GB to download then)
"$DOCKER" build -t "$IMAGE" "$HERE"
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
  -v "$REPO:$REPO:z" -w "$REPO" "$IMAGE" sh ./build.sh "$@"
