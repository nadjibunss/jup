#!/bin/bash
set -e

echo "Starting JupyterLite build with Terminal support..."

# Download dan extract Micromamba
wget -qO- https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba

# Set environment variables
export MAMBA_ROOT_PREFIX="$PWD/micromamba"
export PATH="$PWD/bin:$PATH"

# Buat environment Python
micromamba create -n jupyterenv python=3.11 -c conda-forge -y

# Install dependencies termasuk terminal
micromamba run -n jupyterenv python -m pip install -r requirements-deploy.txt

# Build JupyterLite dengan terminal support
micromamba run -n jupyterenv jupyter lite build --contents content --output-dir dist --debug

echo "Build completed with terminal support!"
