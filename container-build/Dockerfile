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
ENV VULKAN_SDK=/opt/vulkan/current
ENV PATH=$VULKAN_SDK/bin:$PATH

# ROCm through AMD's amdgpu-install for Ubuntu 22.04 (jammy), when its .deb
# was put in this folder (AMD's site does not offer a stable URL); without
# it the image has no ROCm and whisper-dev builds no HIP backend
COPY . /ctx
RUN if ls /ctx/amdgpu-install_*.deb > /dev/null 2>&1; then \
      apt-get update \
      && apt-get install -y /ctx/amdgpu-install_*.deb \
      && apt-get update \
      && amdgpu-install -y --usecase=rocm --no-dkms \
      && rm -rf /var/lib/apt/lists/*; \
    else \
      echo "No amdgpu-install_*.deb: no ROCm in this image"; \
    fi
