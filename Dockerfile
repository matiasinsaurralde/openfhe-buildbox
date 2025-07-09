# Dockerfile for OpenFHE development environment
FROM --platform=linux/amd64 ubuntu:22.04

# Build arguments for OpenFHE version
ARG OPENFHE_VERSION=main
ARG OPENFHE_REF=main

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    libomp-dev \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Build OpenFHE from source
WORKDIR /tmp
RUN git clone https://github.com/openfheorg/openfhe-development.git \
    && cd openfhe-development \
    && git checkout $OPENFHE_REF \
    && mkdir build && cd build \
    && cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED=ON \
    && make -j$(nproc) \
    && make install \
    && ldconfig \
    && cd /tmp \
    && rm -rf openfhe-development

# Set up environment variables
ENV LD_LIBRARY_PATH="/usr/local/lib" 