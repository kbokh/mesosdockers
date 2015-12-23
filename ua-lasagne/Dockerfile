FROM krot/srk-cuda-base:latest
MAINTAINER Kostaintyn Bokhan <k.bokhan@samsung.com> 

# Add image description and version
ENV IMAGE_DESCRIPTION SRK-Lasagne
ENV IMAGE_VERSION 0.2

ENV CONDA_DIR /opt/conda


RUN apt-get update && apt-get install -y --no-install-recommends \
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
    bokeh \
    matplotlib \
    scikit-learn \
    netCDF4 \
  && conda clean -yt

# Install bleeding-edge Theano
RUN pip install --upgrade --no-deps https://github.com/Theano/Theano/archive/master.zip
# Install bleeding-edge Lasagne
RUN pip install --upgrade https://github.com/Lasagne/Lasagne/archive/master.zip

# Set up .theanorc for CUDA 
RUN echo "[nvcc]\nfastmath = True\n[global]\ndevice=cpu\nfloatX=float32\nallow_gc=False" > /root/.theanorc





