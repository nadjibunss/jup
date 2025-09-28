FROM jupyter/scipy-notebook:latest

USER root

# Install system packages (apt, sudo dll tersedia!)
RUN apt-get update && apt-get install -y \
    build-essential \
    vim \
    nano \
    htop \
    git \
    curl \
    wget \
    sudo \
    tree \
    && rm -rf /var/lib/apt/lists/*

# Give jupyter user sudo privileges
RUN echo "jovyan ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install additional Python packages
RUN pip install --no-cache-dir \
    jupyterlab-git \
    jupyterlab-lsp \
    plotly \
    seaborn \
    scikit-learn \
    pandas \
    numpy \
    matplotlib

USER jovyan

# Create Jupyter config directory
RUN mkdir -p /home/jovyan/.jupyter

# Configure JupyterLab WITHOUT token authentication
RUN echo "c.ServerApp.token = ''" >> /home/jovyan/.jupyter/jupyter_lab_config.py && \
    echo "c.ServerApp.password = ''" >> /home/jovyan/.jupyter/jupyter_lab_config.py && \
    echo "c.ServerApp.open_browser = False" >> /home/jovyan/.jupyter/jupyter_lab_config.py && \
    echo "c.ServerApp.port = 8888" >> /home/jovyan/.jupyter/jupyter_lab_config.py && \
    echo "c.ServerApp.ip = '0.0.0.0'" >> /home/jovyan/.jupyter/jupyter_lab_config.py && \
    echo "c.ServerApp.allow_root = True" >> /home/jovyan/.jupyter/jupyter_lab_config.py && \
    echo "c.ServerApp.allow_origin = '*'" >> /home/jovyan/.jupyter/jupyter_lab_config.py && \
    echo "c.ServerApp.disable_check_xsrf = True" >> /home/jovyan/.jupyter/jupyter_lab_config.py

# Create notebooks directory
RUN mkdir -p /home/jovyan/notebooks

# Expose port 8888
EXPOSE 8888

# Start JupyterLab without token
CMD ["jupyter", "lab", "--allow-root", "--no-browser", "--ip=0.0.0.0", "--port=8888"]
