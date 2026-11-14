#!/bin/sh
# whisper-dev: builds the whisper.cpp libraries and collects them in dlls/
# Extra arguments go to the configure step, e.g.
#   ./build.sh -DWHISPER_DEV_CUDA=OFF
set -e
cd "$(dirname "$0")"
if [ ! -f whisper.cpp/include/whisper.h ]; then
  git submodule update --init --recursive
fi
cmake -B build -DCMAKE_BUILD_TYPE=Release "$@"
# "-j" alone means unlimited jobs with make and can exhaust memory: one per CPU
cmake --build build --config Release -j "${JOBS:-$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 4)}"
echo
echo "Libraries are in $(pwd)/dlls"
