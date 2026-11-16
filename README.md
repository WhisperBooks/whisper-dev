# whisper-dev

Builds the [whisper.cpp](https://github.com/ggml-org/whisper.cpp) shared
libraries that [TWhisper](https://github.com/WhisperBooks/TWhisper) loads at
run time, with every backend as its own library (`GGML_BACKEND_DL`), and
collects them in **`dlls/`** at the root of this repository (Debug builds:
`dlls/debug/`). Only `dlls/README.md` and `dlls/.gitignore` are tracked.

- **CPU:** built in every variant the platform supports. ggml picks the best
  one for the machine at run time.
- **GPU:** CUDA and Vulkan (required on Windows), plus AMD HIP when the HIP SDK
  is installed. A machine without a given GPU simply skips that backend.
- **Choosing a device:** TWhisper lists the devices, selects one by name and
  benchmarks them (`TWhisper.Device`, `TWhisperBenchmark`).

## Setup

```
git clone --recurse-submodules https://github.com/WhisperBooks/whisper-dev
```

or, in an existing clone: `git submodule update --init --recursive`.
The `whisper.cpp` submodule is pinned to a commit: `--remote` would move it
to the branch head, and TWhisper's layout check is tied to the whisper.h it was
generated from.

## Prerequisites

| | Windows | Linux | macOS |
|---|---|---|---|
| Compiler | Visual Studio 2022 / 2026 with C++ | gcc / clang | Xcode command line tools |
| CMake | 3.21+ | 3.21+ | 3.21+ |
| CUDA | CUDA Toolkit (`CUDA_PATH`), required | used when `nvcc` is found | - |
| Vulkan | Vulkan SDK (`VULKAN_SDK`), required | Vulkan SDK, or the distribution's packages (Ubuntu: `libvulkan-dev glslc spirv-headers`) | (Metal is built in) |
| AMD HIP | HIP SDK (`HIP_PATH`) + Ninja, optional | ROCm (`ROCM_PATH`), optional | - |

On Windows `build.bat` works from any prompt: it sets up the x64 Visual
Studio environment itself and builds with **Ninja Multi-Config** (Ninja comes
with Visual Studio's "C++ CMake tools"), as whisper.cpp's own release builds
do. The Visual Studio generator is not used because it compiles CUDA through
NVIDIA's MSBuild integration, which may be missing for the installed Visual
Studio ("No CUDA toolset found").

## Build

```
build.bat                       Windows
./build.sh                      Linux / macOS
```

which is, on Windows (in an x64 Visual Studio environment)

```
cmake -B build -G "Ninja Multi-Config"
cmake --build build --config Release
```

`build.sh` builds with one job per CPU (`JOBS=n ./build.sh` to change it):
`cmake --build -j` without a number means unlimited jobs with make, which can
run a machine out of memory. `build.bat` uses Ninja's default (CPUs + 2);
`set JOBS=n` first to limit it - CUDA compiles need a lot of memory each.

Extra arguments to `build.bat` / `build.sh` go to the configure step:

| Option | Default | |
|---|---|---|
| `WHISPER_DEV_CUDA` | Windows ON, Linux if `nvcc` found | CUDA backend |
| `WHISPER_DEV_VULKAN` | Windows ON, Linux if `VULKAN_SDK` is set or `glslc` is found | Vulkan backend |
| `WHISPER_DEV_HIP` | ON if `HIP_PATH` / `ROCM_PATH` set | AMD HIP backend |
| `WHISPER_DEV_HIP_TARGETS` | `gfx1030;gfx1100;gfx1101;gfx1102;gfx1200;gfx1201` | AMD GPU architectures |
| `CUDA_ALL` | OFF | CUDA archs `50;75;86;89;120` instead of ggml's default list (`75;86;89;120` with CUDA 13+, which no longer builds for Maxwell / Pascal / Volta) |
| `WHISPER_DEV_BLAS` | OFF | OpenBLAS backend (whisper.cpp always uses one that is present, so it takes the choice away) |
| `WHISPER_DEV_OPENVINO` | OFF | OpenVINO encoder (links into whisper, which then needs OpenVINO everywhere) |

A required SDK that is missing stops the configure step with a message; pass
`-DWHISPER_DEV_<X>=OFF` to build without that backend.

## What lands in `dlls/` (Windows)

| File | |
|---|---|
| `whisper.dll`, `ggml.dll`, `ggml-base.dll` | the libraries TWhisper loads |
| `ggml-cpu-*.dll` | CPU variants (`x64`, `sse42`, `haswell`, `skylakex`, `zen4`, ...) |
| `ggml-cuda.dll` + `cudart64_*`, `cublas64_*`, `cublasLt64_*` | CUDA backend and its runtime |
| `ggml-vulkan.dll` | Vulkan backend (`vulkan-1.dll` comes with the GPU driver) |
| `ggml-hip.dll` + `hipblas`, `rocblas`, `rocblas/library` | HIP backend (with `WHISPER_DEV_HIP`) |
| `msvcp140.dll`, `vcruntime140*.dll`, `vcomp140.dll` | MSVC + OpenMP runtime, app-local |

On Linux / macOS the same set as `lib*.so` / `lib*.dylib` (with their
soname copies, e.g. `libggml.so.0`), plus on Linux with gcc OpenMP's
runtime `libgomp.so.1` (every `libggml-cpu-*.so` needs it; Steam's Linux
runtime and minimal systems may not have it). The libraries find each
other in their own folder (RUNPATH `$ORIGIN`, macOS `@loader_path`), so
the folder can go anywhere - next to the program, or a `lib` folder
named by `TWhisper.LibraryPath` - and they carry no path of the build
machine (source paths in assert messages start at `whisper.cpp/`).

On Linux, which backends get built depends on what is installed: CUDA
when `nvcc` is found, Vulkan when `glslc` (or `VULKAN_SDK`) is, HIP when
`ROCM_PATH` is set. None of them needs that GPU in the build machine.
Install the SDKs from their makers (the distributions' packages trail):

- Vulkan: LunarG's SDK tarball (vulkan.lunarg.com), then
  `source <version>/setup-env.sh` (sets `VULKAN_SDK`, puts `glslc` on PATH).
- CUDA: NVIDIA's apt repository (developer.nvidia.com/cuda-downloads,
  "deb (network)"), `cuda-toolkit` only - no driver needed to build -
  and `/usr/local/cuda/bin` on PATH.
  With CUDA 13 the backend runs on Turing (GTX 16xx / RTX 20xx) and
  newer, and needs NVIDIA driver 580 or newer on the user's system; where
  it cannot load, ggml skips it and Vulkan / the CPU are used.
- ROCm: AMD's `amdgpu-install` (repo.radeon.com), `amdgpu-install
  --usecase=rocm --no-dkms`, and `ROCM_PATH=/opt/rocm`.

**Build in the container for other Linux systems.** Libraries built on
the host need the host's glibc or newer (Ubuntu 26.04: 2.43 - not even
Ubuntu 24.04 loads them). `container-build/build.sh` builds in Ubuntu
22.04 (glibc 2.35, the oldest ROCm supports) with CUDA, ROCm, the Vulkan
SDK and patchelf inside, and fills `dlls/` the same way; it builds
ffmpeg-dev too (`container-build/build.sh ../ffmpeg-dev`). It needs Docker
or Podman - **`container-build/README.md` has everything: why, what to
install and how (Docker, Podman), the AMD package, building, checking
the result, problems.** `./build.sh` prints first what it found
(CUDA, Vulkan SDK, ROCm, patchelf) and why a backend will be missing;
ROCm is found in `/opt/rocm` without `ROCM_PATH`.

**One build for every Linux system:** with CUDA or HIP built,
`WHISPER_DEV_BUNDLE_RUNTIMES` (on) copies the runtime libraries the
backends need into `dlls/` (`cmake/bundle_linux.cmake`): CUDA's cudart,
cuBLAS and cuBLASLt; ROCm's amdhip64, hipBLAS, rocBLAS, HSA and what
they use - everything found under the SDK folders - plus rocBLAS's and
hipBLASLt's kernel files for `WHISPER_DEV_HIP_TARGETS` only (in
`dlls/rocblas/library`, `dlls/hipblaslt/library`). Each gets RUNPATH
`$ORIGIN` through `patchelf` (needed: github.com/NixOS/patchelf, or the
distribution's), so the folder needs no SDK on the target system - only
the GPU driver: NVIDIA's (`libcuda.so`) for CUDA, the kernel's amdgpu
for HIP, any driver with Vulkan for Vulkan. The build lists the system
libraries the bundled set still needs (glibc, libstdc++, libdrm, libnuma,
...) - check those exist on the oldest target. Expect a large folder
(cuBLASLt alone is several hundred MB; rocBLAS kernels grow with each
target). `-DWHISPER_DEV_BUNDLE_RUNTIMES=OFF` leaves them out (systems with
the SDK installed).

On Windows, HIP is built in a second tree (`build/hip`) with the HIP SDK's own
clang, because that compiler cannot share a tree with MSVC, which CUDA needs.
Only `ggml-hip.dll` is taken from that tree. Both trees come from the same
checkout, so the backend API version matches.

## Using them

Copy `dlls/` next to the executable, or set `TWhisper.LibraryPath` to it, then:

```
WhisperConsole --check                          library, layout check, device list
WhisperConsole --bench ggml-base.en.bin jfk.wav time every device
```

## Benchmarks

`scripts/` and the `bench-*.bat` files run whisper.cpp's own `whisper-bench`
/ `whisper-cli` from `build/bin/Release` (examples are still built). Note that
`whisper-bench` times the encoder only; TWhisper's benchmark times real
transcription per device.
