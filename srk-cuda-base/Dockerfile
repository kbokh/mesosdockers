FROM debian:jessie
MAINTAINER Kostaintyn Bokhan <k.bokhan@samsung.com> 

# Add image description and version
ENV IMAGE_DESCRIPTION SRK-Cuda-Base
ENV IMAGE_VERSION 0.1

ENV CUDA_MAJOR_VERSION 7.5
ENV CUDA_MINOR_VERSION 18

ENV BUILD_PACKAGES build-essential lsb-release bzip2
ENV RUNTIME_PACKAGES curl ca-certificates module-init-tools

RUN apt-get update \ 
    && apt-get -qqy install --no-install-recommends $BUILD_PACKAGES \
    && apt-get -qqy install --no-install-recommends $RUNTIME_PACKAGES \
    && cd /tmp \
    && curl -s http://developer.download.nvidia.com/compute/cuda/${CUDA_MAJOR_VERSION}/Prod/local_installers/cuda_${CUDA_MAJOR_VERSION}.${CUDA_MINOR_VERSION}_linux.run \
    && chmod +x cuda_*_linux.run && ./cuda_*_linux.run -extract=`pwd` \
    && ./NVIDIA-Linux-x86_64-*.run -s --no-kernel-module \
    && ./cuda-linux64-rel-*.run -noprompt \
    && rm -rf *
    && apt-get remove --purge -y $BUILD_PACKAGES $(apt-mark showauto) && rm -rf /var/lib/apt/lists/*


# Setup CUDA environment 
ENV CUDA_ROOT /usr/local/cuda
ENV PATH $CUDA_ROOT/bin:$PATH
ENV LD_LIBRARY_PATH $CUDA_ROOT/lib64:$LD_LIBRARY_PATH
ENV LIBRARY_PATH $LIBRARY_PATH:$CUDA_ROOT/lib64
ENV CPATH $CPATH:$CUDA_ROOT/include






