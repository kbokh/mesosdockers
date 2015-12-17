FROM debian:jessie
MAINTAINER Kostaintyn Bokhan  

# Add image description and version
ENV IMAGE_DESCRIPTION UA-Base-Conda
ENV IMAGE_VERSION 0.1

ENV CONDA_DIR /opt/conda


RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		wget \
		module-init-tools \
		build-essential \
		lsb-release \
		bzip2 \
		libglib2.0-0 \
		libxext6 libsm6 \
		libxrender1 \
	&& rm -rf /var/lib/apt/lists/*


ENV LANG C.UTF-8

# Install conda
RUN mkdir -p $CONDA_DIR && \
    echo 'export PATH=$CONDA_DIR/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh && \ 
    /bin/bash /Miniconda-latest-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda-latest-Linux-x86_64.sh && \
    $CONDA_DIR/bin/conda update --yes conda

ENV PATH $CONDA_DIR/bin:$PATH

# Install conda packages
RUN conda install --yes \
    pip \
  && conda clean -yt






