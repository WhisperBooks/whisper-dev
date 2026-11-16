# container-build

Builds the **Linux** libraries - whisper.cpp from this repository and FFmpeg
from ffmpeg-dev - inside an Ubuntu 22.04 container that has the GPU SDKs,
so the result runs on every Linux with glibc 2.35 or newer.

## Why a container

A Linux library needs the C library (glibc) it was built against, or a
newer one. Built directly on a new system - Ubuntu 26.04 has glibc 2.43 -
the libraries refuse to load on older ones ("GLIBC_2.43 not found"), even
on Ubuntu 24.04. Built in Ubuntu 22.04 (glibc 2.35), they run on:

| System | glibc | Runs |
|---|---|---|
| Ubuntu 22.04, 24.04, 26.04 | 2.35 / 2.39 / 2.43 | yes |
| Debian 12 | 2.36 | yes |
| Fedora, Arch, current SteamOS (Steam Deck, Steam Machine) | newer | yes |
| Inside Steam's Linux runtime | the host's, when newer | yes |
| Ubuntu 20.04, Debian 11 and older | 2.31 and older | no (ROCm and CUDA 13 do not support them either) |

ROCm supports nothing older than Ubuntu 22.04, which is why 22.04 is the
base. The container also keeps the SDKs off your system: you need no
CUDA, ROCm or Vulkan SDK installed, and no GPU, to build.

## What you need

1. A Linux PC, x86-64, with about 40 GB free (the image with CUDA, ROCm
   and the Vulkan SDK is large) and a fast connection for the first run.
   Building on a Steam Deck is not recommended: use a desktop Linux.
2. **Docker or Podman** (below).
3. whisper-dev and ffmpeg-dev cloned next to each other with their
   submodules:

   ```
   git clone --recurse-submodules https://github.com/WhisperBooks/whisper-dev
   ```

   ```
   git clone --recurse-submodules https://github.com/G3DGames/ffmpeg-dev
   ```

4. Nothing for the AMD HIP backend: the image fetches AMD's
   `amdgpu-install` for Ubuntu 22.04 (jammy) itself - the address is
   `AMDGPU_INSTALL_URL` in the `Dockerfile` (release 31.60:
   `https://repo.radeon.com/amdgpu-install/31.60/ubuntu/jammy/`). For
   another ROCm release, either put that release's **jammy**
   `amdgpu-install_<version>_all.deb` in this folder (it wins; git ignores
   it) or build the image with `--build-arg AMDGPU_INSTALL_URL=...`
   (`""` builds without ROCm). Not the package for your own Ubuntu
   version: the container is Ubuntu 22.04.

## Installing Docker or Podman

Either works; the script uses `docker` unless `DOCKER=podman` is set.

### Docker on Ubuntu (from Docker's own repository)

```
sudo apt install ca-certificates curl
```

```
sudo install -m 0755 -d /etc/apt/keyrings
```

```
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
```

```
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" | sudo tee /etc/apt/sources.list.d/docker.list
```

```
sudo apt update
```

```
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin
```

If `apt update` reports that Docker's repository has no release for your
Ubuntu version (a new release, before Docker publishes for it), write
`noble` (24.04) instead of `$(. /etc/os-release && echo $VERSION_CODENAME)`
in the `echo` line and run `apt update` again.

Then let your user run Docker - without this every command needs `sudo`
and the built files belong to root - and **log out and in again**:

```
sudo usermod -aG docker $USER
```

Check:

```
docker run --rm hello-world
```

Debian: the same with `debian` in place of `ubuntu` in the two URLs.
Other distributions: Docker's instructions at docs.docker.com/engine/install.

### Podman (Fedora has it already; elsewhere one package)

Podman needs no service and no group: it runs as your user. Install it
(Fedora: present; Ubuntu / Debian: `sudo apt install podman`; Arch:
`sudo pacman -S podman`), then run the builds with `DOCKER=podman`:

```
DOCKER=podman container-build/build.sh ../ffmpeg-dev
```

The script then keeps your user id inside the container
(`--userns=keep-id`), so the built files belong to you.

### Windows

The libraries here are Linux libraries. On Windows, whisper-dev's
`build.bat` and ffmpeg-dev's `build.bat` build the Windows ones directly
(no container). Docker Desktop with WSL 2 can run this script inside a
WSL Ubuntu, but that is not needed for Windows builds.

## Building

From the whisper-dev folder - FFmpeg first (quick, and it shows the image
works), then whisper.cpp:

```
container-build/build.sh ../ffmpeg-dev
```

```
container-build/build.sh
```

The first run builds the image: CMake, CUDA, the Vulkan SDK and ROCm. That is a download of several GB and can take an
hour; later runs reuse the image (a `.deb` put here later builds the
ROCm step once more). The repository is mounted into the container at the same path it has on
your machine, so the results land where a normal build puts them:

- ffmpeg-dev: `dlls/linux-x64/` (libraries, licence texts, BUILD-INFO.txt)
- whisper-dev: `dlls/` (libwhisper, libggml, the CPU variants, the GPU
  backends, their bundled CUDA / ROCm runtimes, libgomp)

The build trees are `build-container/` in each repository, separate from
a normal build's `build/`. Arguments after the repository go to its
`build.sh` (`container-build/build.sh -DWHISPER_DEV_VULKAN=OFF`); `JOBS=4`
limits the parallel compiles (CUDA and ROCm compiles need a lot of memory
each).

whisper-dev is built with `CUDA_ALL=ON` here (compiled code for the
GeForce generations 75/86/89/120, as well as PTX), the build to ship:
ggml's default list has only PTX for some cards (sm_75: GTX 16xx, RTX 20xx),
and a driver older than the CUDA toolkit cannot compile that PTX - ggml
then stops the program ("the provided PTX was compiled with an
unsupported toolchain"). `-DCUDA_ALL=OFF` after the script's name turns it
off.

Before compiling whisper-dev, the script checks that the image has CUDA,
the Vulkan SDK and ROCm, and stops if one is missing - so an hour of CUDA
compiling never ends without HIP. `ALLOW_MISSING=1` builds without the
missing ones on purpose.

At its start whisper-dev's build lists what it found - CUDA, the Vulkan
SDK, ROCm, patchelf - and why a backend is missing; near the end it says
how many CUDA / ROCm runtime libraries and kernel files it bundled, and
which system libraries those still need.

## Checking the result

The newest glibc a library needs - must be 2.35 or lower:

```
objdump -T dlls/libggml-base.so | grep -o 'GLIBC_[0-9.]*' | sort -uV | tail -n 1
```

```
objdump -T ../ffmpeg-dev/dlls/linux-x64/libavcodec.so.62 | grep -o 'GLIBC_[0-9.]*' | sort -uV | tail -n 1
```

The libraries find each other in their own folder:

```
readelf -d dlls/libwhisper.so | grep RUNPATH
```

prints `[$ORIGIN]`.

## SDK versions

Set when the image is built (`Dockerfile`, `ARG` lines): CMake
(`CMAKE_VERSION`), the CUDA toolkit package (`CUDA_PACKAGE`,
cuda-toolkit-13-5), the Vulkan SDK (`VULKAN_SDK_VERSION`, latest),
patchelf (`PATCHELF_VERSION`), ROCm (`AMDGPU_INSTALL_URL`, or a `.deb` here).
To change one, build the image by hand once, e.g.

```
docker build -t whisper-dev-build:ubuntu22.04 --build-arg CUDA_PACKAGE=cuda-toolkit-13-6 container-build
```

To start afresh (a new ROCm, say): `docker rmi whisper-dev-build:ubuntu22.04`.

## Problems

- `docker: not found` - Docker (or Podman) is not installed: above.
- `permission denied while trying to connect to the Docker daemon` - your
  user is not in the `docker` group yet, or you did not log in again.
- `E: Unable to locate package cuda-toolkit-13-5` - NVIDIA has no such
  package (yet / any more): build the image with another `CUDA_PACKAGE`.
- A download fails during the image build - run the script again; the
  steps that finished are kept.
- Built files belong to root - the build ran with `sudo`: do not; join
  the `docker` group instead (or use Podman).
- `No rule to make target '.../ffmpeg/Makefile'` (FFmpeg) - that
  repository's `build.sh` is older than the container support and reused
  the host's `build/` folder: `git pull` in it (ffmpeg-dev 3709326 or
  later), then build again.
- `CUDA error: the provided PTX was compiled with an unsupported
  toolchain` when a program runs - the card had only PTX and its driver is
  older than the CUDA toolkit: a build from before `CUDA_ALL` became the
  container default; build again (the CUDA backend is recompiled). Or
  update the NVIDIA driver.
- `does not contain the HIP runtime CMake package`, with no
  `hip-lang-config.cmake` anywhere in the image - ROCm 7.x's `rocm` use
  case installs no development files; the Dockerfile's last step adds them
  (`amdrocm-core-dev`, `-runtime-dev`, `-blas-dev`, `-hipblas-common-dev`).
  An image built before that step: run `container-build/build.sh` again,
  only the new step is built.
- `does not contain the HIP runtime CMake package` (whisper-dev) - ROCm
  7.x keeps its compiler in a folder of its own (`/opt/rocm/core-NN`), and
  CMake looked for HIP there. whisper-dev finds the right folder itself
  (the `whisper-dev: ROCm root for HIP ...` line); if it cannot, run
  `container-build/build.sh -DCMAKE_HIP_COMPILER_ROCM_ROOT=<folder>`
  with the folder that holds `lib/cmake/hip-lang`.
