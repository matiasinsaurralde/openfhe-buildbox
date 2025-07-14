# Dockerfile for OpenFHE development environment
FROM ubuntu:22.04

# Build arguments for OpenFHE version
ARG OPENFHE_VERSION=main
ARG OPENFHE_REF=main

# Install system dependencies including ccache
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    libomp-dev \
    gcc \
    g++ \
    ccache \
    pkg-config \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Configure ccache
RUN ccache --max-size=2G
ENV CC="ccache gcc"
ENV CXX="ccache g++"

# Build OpenFHE from source
WORKDIR /tmp
RUN git clone https://github.com/openfheorg/openfhe-development.git \
    && cd openfhe-development \
    && echo "Available branches:" && git branch -a \
    && echo "Available tags:" && git tag | head -10 \
    && git checkout $OPENFHE_REF \
    && echo "Building OpenFHE version: $OPENFHE_VERSION, ref: $OPENFHE_REF" \
    && echo "Current directory: $(pwd)" \
    && echo "Git status:" && git status \
    && echo "Git log (last 5 commits):" && git log --oneline -5 \
    && mkdir build && cd build \
    && echo "Running cmake..." \
    && cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED=ON \
    && echo "CMake configuration completed successfully" \
    && echo "Running make with $(nproc) jobs..." \
    && make -j$(nproc) VERBOSE=1 \
    && echo "Make completed successfully" \
    && echo "Running make install..." \
    && make install \
    && echo "Make install completed successfully" \
    && echo "Running ldconfig..." \
    && ldconfig \
    && cd /tmp \
    && rm -rf openfhe-development

# Set up environment variables
ENV LD_LIBRARY_PATH="/usr/local/lib" 