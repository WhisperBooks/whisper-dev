# whisper-dev's build container: Ubuntu 22.04 (glibc 2.35) with the GPU
# SDKs from their makers, so the libraries built in it run on every Linux
# with glibc 2.35 or newer (Ubuntu 22.04+, Debian 12+, Fedora, Arch,
# SteamOS). ROCm itself supports nothing older, so 22.04 is the floor.
# Built and run by build.sh in this folder; see README.md.
FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
# Kitware's CMake (22.04 has 3.22: too old for CUDA 13's architecture names)
ARG CMAKE_VERSION=3.31.8
# NVIDIA's CUDA toolkit package (no driver: building needs no GPU)
ARG CUDA_PACKAGE=cuda-toolkit-13-5
# LunarG's Vulkan SDK: "latest" or a version such as 1.4.321.1
ARG VULKAN_SDK_VERSION=latest
ARG PATCHELF_VERSION=0.18.0
# AMD's amdgpu-install for Ubuntu 22.04 (jammy), which installs ROCm: used
# when no amdgpu-install_*.deb was put in this folder; "" = no ROCm (no HIP)
ARG AMDGPU_INSTALL_URL=https://repo.radeon.com/amdgpu-install/31.60/ubuntu/jammy/amdgpu-install_31.60.316000-1_all.deb

RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential git ninja-build nasm pkg-config ca-certificates curl xz-utils file python3 \
    && rm -rf /var/lib/apt/lists/*

# the repositories are mounted from the host and owned by another user
RUN git config --system --add safe.directory '*'

RUN curl -fsSL https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz \
      | tar xz -C /opt \
    && ln -s /opt/cmake-${CMAKE_VERSION}-linux-x86_64/bin/* /usr/local/bin/

RUN curl -fsSL https://github.com/NixOS/patchelf/releases/download/${PATCHELF_VERSION}/patchelf-${PATCHELF_VERSION}-x86_64.tar.gz \
      | tar xz -C /usr/local

# CUDA from NVIDIA's repository
RUN curl -fsSLO https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb \
    && dpkg -i cuda-keyring_1.1-1_all.deb && rm cuda-keyring_1.1-1_all.deb \
    && apt-get update && apt-get install -y --no-install-recommends ${CUDA_PACKAGE} \
    && rm -rf /var/lib/apt/lists/*
ENV PATH=/usr/local/cuda/bin:$PATH

# Vulkan SDK from LunarG (its x86_64 folder: headers, loader, glslc)
RUN mkdir -p /opt/vulkan && cd /opt/vulkan \
    && if [ "${VULKAN_SDK_VERSION}" = latest ]; then \
         URL=https://sdk.lunarg.com/sdk/download/latest/linux/vulkan-sdk.tar.xz; \
       else \
         URL=https://sdk.lunarg.com/sdk/download/${VULKAN_SDK_VERSION}/linux/vulkansdk-linux-x86_64-${VULKAN_SDK_VERSION}.tar.xz; \
       fi \
    && curl -fsSL "$URL" | tar xJ \
    && ln -s "$(ls -d /opt/vulkan/*/x86_64 | head -n 1)" /opt/vulkan/current
# The Vulkan loader to link against (libvulkan.so): LunarG's tarball may
# hold it only as libvulkan.so.1, or not at all (1.4.363: CMake found the
# headers but no library). A missing plain name gets a link; no loader at
# all: Ubuntu's libvulkan-dev. Only the link step uses it - at run time
# libggml-vulkan.so takes the target system's loader (libvulkan.so.1, part
# of every Vulkan driver install), and the loader's ABI does not change.
RUN cd /opt/vulkan/current/lib 2>/dev/null \
      && if [ ! -e libvulkan.so ] && [ -e libvulkan.so.1 ]; then ln -s libvulkan.so.1 libvulkan.so; fi; \
    if [ ! -e /opt/vulkan/current/lib/libvulkan.so ]; then \
      apt-get update && apt-get install -y --no-install-recommends libvulkan-dev \
      && rm -rf /var/lib/apt/lists/*; \
    fi
ENV VULKAN_SDK=/opt/vulkan/current
ENV PATH=$VULKAN_SDK/bin:$PATH

# ROCm through AMD's amdgpu-install for Ubuntu 22.04 (jammy): a .deb put in
# this folder, else AMDGPU_INSTALL_URL; neither: no ROCm, no HIP backend
# amdgpu-install also registers AMD's "graphics" repository (Mesa, OpenGL,
# Vulkan user space), which ROCm does not need and AMD does not publish for
# every release and Ubuntu version (31.60: graphics/26.16 jammy is a 404,
# and apt stops) - its lines are removed before apt reads the lists
COPY . /ctx
RUN DEB=$(ls /ctx/amdgpu-install_*.deb 2>/dev/null | head -n 1); \
    if [ -z "$DEB" ] && [ -n "${AMDGPU_INSTALL_URL}" ]; then \
      DEB=/tmp/amdgpu-install.deb; \
      curl -fsSL -o "$DEB" "${AMDGPU_INSTALL_URL}"; \
    fi; \
    if [ -n "$DEB" ]; then \
      apt-get update \
      && apt-get install -y "$DEB" \
      && sed -i '\#repo.radeon.com/graphics#d' /etc/apt/sources.list.d/*.list \
      && apt-get update \
      && amdgpu-install -y --usecase=rocm --no-dkms \
      && rm -rf /var/lib/apt/lists/* /tmp/amdgpu-install.deb; \
    else \
      echo "No amdgpu-install package: no ROCm in this image"; \
    fi

# ROCm 7.x packaging (amdrocm-*): the "rocm" use case installs the HIP
# runtime, the compiler and the GPU kernels, but none of the development
# files - no hip-lang / hip CMake packages, no hipBLAS / rocBLAS headers -
# so CMake cannot build ggml-hip. Added in a step of its own, so the ROCm
# step above stays cached. The version suffix (10.1) is read from the
# installed runtime, so a newer amdgpu-install picks its own.
RUN if ls /opt/rocm/bin/hipconfig >/dev/null 2>&1; then \
      V=$(dpkg-query -W -f '${Package}\n' 'amdrocm-runtime*' 2>/dev/null \
          | sed -n 's/^amdrocm-runtime\([0-9][0-9.]*\)$/\1/p' | head -n 1); \
      if [ -n "$V" ]; then \
        apt-get update \
        && apt-get install -y --no-install-recommends \
             amdrocm-core-dev$V amdrocm-runtime-dev$V \
             amdrocm-blas-dev$V amdrocm-hipblas-common-dev$V \
        && rm -rf /var/lib/apt/lists/*; \
      else \
        echo "ROCm without amdrocm-runtime packages: older packaging, dev files came with it"; \
      fi; \
    fi
