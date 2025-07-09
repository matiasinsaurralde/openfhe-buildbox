# OpenFHE Buildbox

[![CI](https://github.com/matiasinsaurralde/openfhe-buildbox/actions/workflows/docker.yml/badge.svg)](https://github.com/matiasinsaurralde/openfhe-buildbox/actions/workflows/docker.yml)

A Docker base image containing pre-built OpenFHE libraries and development tools for creating language bindings and applications.

## Overview

This repository provides a Docker image with OpenFHE (Open Fully Homomorphic Encryption) libraries pre-compiled and ready to use. It's designed as a base image for projects that need to create language bindings or applications using OpenFHE.

## What's Included

- **OpenFHE Libraries**: Pre-compiled OpenFHE libraries installed in `/usr/local/lib`
- **Headers**: OpenFHE headers available in `/usr/local/include`
- **Build Tools**: Essential build tools (gcc, g++, cmake, git, wget)
- **OpenMP**: OpenMP development libraries for parallel processing
- **Environment**: Proper `LD_LIBRARY_PATH` configuration

## Usage

### Using the Base Image

```dockerfile
FROM ghcr.io/matiasinsaurralde/openfhe-buildbox:latest

# Add your language-specific tools
RUN apt-get update && apt-get install -y golang-go

# Set your working directory
WORKDIR /app

# Copy your source code
COPY . .

# Build your application with OpenFHE...
```

### Local Development

```bash
# Build the image locally
docker build -t openfhe-buildbox .

# Run a container for development
docker run -it --rm openfhe-buildbox bash
```

## Available Tags

- `latest` - Latest build from main branch

## Building OpenFHE

The image builds OpenFHE from source with the following configuration:
- **Build Type**: Release
- **Shared Libraries**: Enabled
- **Platform**: Linux AMD64
- **Base OS**: Ubuntu 22.04 LTS

## Environment Variables

- `LD_LIBRARY_PATH=/usr/local/lib` - Path to OpenFHE libraries

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## Related Projects

- [OpenFHE](https://github.com/openfheorg/openfhe-development) - The underlying homomorphic encryption library
- [Awesome OpenFHE](https://github.com/openfheorg/awesome-openfhe#openfhe-software-interfaces) - Curated list of OpenFHE tools, interfaces, and resources

## Support

If you encounter issues or have questions, please open an issue on GitHub.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
