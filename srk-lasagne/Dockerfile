FROM debian:jessie
MAINTAINER Kostaintyn Bokhan <k.bokhan@samsung.com> 

# Add image description and version
ENV IMAGE_DESCRIPTION SRK-Lasagne
ENV IMAGE_VERSION 0.1

ENV CUDA_MAJOR_VERSION 7.5
ENV CUDA_MINOR_VERSION 18

ENV CONDA_DIR /opt/conda


RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		wget \
		module-init-tools \
		build-essential \
		git \
		lsb-release \
		bzip2 \
		libglib2.0-0 \
		libxext6 libsm6 \
		libxrender1 \
	&& rm -rf /var/lib/apt/lists/*


# Install CUDA
RUN cd /tmp && \
# Download run file
  wget --quiet http://developer.download.nvidia.com/compute/cuda/${CUDA_MAJOR_VERSION}/Prod/local_installers/cuda_${CUDA_MAJOR_VERSION}.${CUDA_MINOR_VERSION}_linux.run && \
# Make the run file executable and extract
  chmod +x cuda_*_linux.run && ./cuda_*_linux.run -extract=`pwd` && \
# Install CUDA drivers (silent, no kernel)
  ./NVIDIA-Linux-x86_64-*.run -s --no-kernel-module && \
# Install toolkit (silent)  
  ./cuda-linux64-rel-*.run -noprompt && \
# Clean up
  rm -rf *

# Setup CUDA environment 
ENV CUDA_ROOT /usr/local/cuda
ENV PATH $CUDA_ROOT/bin:$PATH
ENV LD_LIBRARY_PATH $CUDA_ROOT/lib64:$LD_LIBRARY_PATH
ENV LIBRARY_PATH $LIBRARY_PATH:$CUDA_ROOT/lib64
ENV CPATH $CPATH:$CUDA_ROOT/include

ENV LANG C.UTF-8

# Install conda
RUN mkdir -p $CONDA_DIR && \
    echo 'export PATH=$CONDA_DIR/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh && \ 
    /bin/bash /Miniconda3-latest-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-latest-Linux-x86_64.sh && \
    $CONDA_DIR/bin/conda update --yes conda

ENV PATH $CONDA_DIR/bin:$PATH

# Install conda packages
RUN conda install --yes \
    pip \
    bokeh \
    && conda clean -yt

# Install bleeding-edge Theano
RUN pip install --upgrade --no-deps https://github.com/Theano/Theano/archive/master.zip
# Install bleeding-edge Lasagne
RUN pip install --upgrade https://github.com/Lasagne/Lasagne/archive/master.zip

# Set up .theanorc for CUDA 
RUN echo "[nvcc]\nfastmath = True\n[global]\ndevice=cpu\nfloatX=float32\nallow_gc=False" > /root/.theanorc





