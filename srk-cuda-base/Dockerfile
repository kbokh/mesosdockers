FROM debian:jessie
MAINTAINER Kostaintyn Bokhan <k.bokhan@samsung.com> 

# Add image description and version
ENV IMAGE_DESCRIPTION SRK-Cuda-Base
ENV IMAGE_VERSION 0.1

ENV CUDA_MAJOR_VERSION 7.5
ENV CUDA_MINOR_VERSION 18

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		wget \
		module-init-tools \
		build-essential \
		lsb-release \
		bzip2 \
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






