# container-build

Builds the Linux libraries inside Ubuntu 22.04 (glibc 2.35) with the GPU
SDKs installed from their makers, so the result runs on every Linux with
glibc 2.35 or newer - Ubuntu 22.04 and later, Debian 12, Fedora, Arch,
SteamOS (the Deck, the Steam Machine), and inside Steam's runtime. Built
on the host instead, the libraries need the host's glibc or newer (Ubuntu
26.04: 2.43). ROCm supports nothing older than Ubuntu 22.04, so that is
the floor.

The same container builds ffmpeg-dev, so both sets share the baseline.

## What is in the image

- Ubuntu 22.04 with gcc, ninja, nasm, git
- CMake from Kitware's releases (`CMAKE_VERSION`)
- CUDA toolkit from NVIDIA's repository (`CUDA_PACKAGE`, cuda-toolkit-13-5)
- Vulkan SDK from LunarG (`VULKAN_SDK_VERSION`, latest)
- ROCm through AMD's `amdgpu-install`, when its `.deb` is in this folder
- patchelf from its GitHub releases (the CUDA / ROCm runtimes are
  bundled into `dlls/` with RUNPATH `$ORIGIN`)

## Use

Docker (or Podman: `DOCKER=podman`) on the build machine. No GPU and no
SDK on the host is needed. For HIP, download AMD's `amdgpu-install` .deb
**for Ubuntu 22.04 (jammy)** - not the one for the host's Ubuntu - into
this folder first (it is not tracked).

```
container-build/build.sh
```

```
container-build/build.sh ../ffmpeg-dev
```

The first run builds the image (several GB: CUDA, ROCm, the Vulkan SDK);
later runs reuse it. The repository is mounted into the container, so
the libraries land in `dlls/` as with a normal build; the build tree is
`build-container/`. Arguments after the repository go to its `build.sh`
(`container-build/build.sh -DCUDA_ALL=ON`). To pick other SDK versions,
build the image by hand, e.g.

```
docker build -t whisper-dev-build:ubuntu22.04 --build-arg CUDA_PACKAGE=cuda-toolkit-13-6 container-build
```

Check a result: `objdump -T dlls/libggml-base.so | grep -o 'GLIBC_[0-9.]*' | sort -uV | tail -n 1`
should print GLIBC_2.35 or lower.
