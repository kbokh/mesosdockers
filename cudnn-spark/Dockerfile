FROM nvidia/cuda:cudnn
MAINTAINER Kostaintyn Bokhan <konstboh@gmail.com>

# Add image description and version
ENV IMAGE_DESCRIPTION cudnn-spark
ENV IMAGE_VERSION 0.1
ENV JAVA_VERSION 7
ENV MESOS_VERSION 0.28.0

RUN apt-get remove -y --auto-remove openjdk* && \
    echo "deb http://repos.mesosphere.com/ubuntu trusty main" | sudo tee /etc/apt/sources.list.d/mesosphere.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
    apt-get update && \
    apt-get -y --download-only --no-install-recommends install mesos && \
    mkdir /tmp/mesos && \
    dpkg-deb -x /var/cache/apt/archives/mesos*.deb /tmp/mesos && \
    apt-get install -y --no-install-recommends \
    wget \
    libnss3 \
    libsvn1 \
    openjdk-7-jre-headless \
    curl \
    bzip2 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/oracle-jdk*

RUN cp /tmp/mesos/usr/lib/libmesos* /usr/lib/ && \
    rm -r -f /tmp/mesos/
ENV MESOS_NATIVE_JAVA_LIBRARY /usr/lib/libmesos.so

ENV SPARK_VERSION 1.6.1
ENV SPARK_HOME /opt/spark
RUN mkdir ${SPARK_HOME} && \
    curl http://www-eu.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.6.tgz \
    | tar --strip-components=1 -xzC ${SPARK_HOME} && \
    rm ${SPARK_HOME}/lib/spark-examples-*.jar

# http://blog.stuart.axelbrooke.com/python-3-on-spark-return-of-the-pythonhashseed
ENV PYTHONHASHSEED 0
ENV PYTHONIOENCODING UTF-8
ENV LANG C.UTF-8

ENV PYTHON_VERSION 3
ENV CONDA_HOME /opt/conda
ENV PATH $PATH:$SPARK_HOME/bin:$CONDA_HOME/bin
RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda${PYTHON_VERSION}-latest-Linux-x86_64.sh && \
        /bin/bash /Miniconda${PYTHON_VERSION}-latest-Linux-x86_64.sh -b -p ${CONDA_HOME} && \
        rm Miniconda${PYTHON_VERSION}-latest-Linux-x86_64.sh

RUN conda install numpy scipy

# Add non privileged user for security reason - launching jobs as a non privileged user
RUN adduser -u 1001 --disabled-password --gecos "" worker && \
    chown -R worker:worker /opt/spark && \
    chmod o+rwx /

USER worker

ENV PYTHONHASHSEED 0
ENV PYTHONIOENCODING UTF-8
ENV LANG C.UTF-8

ENV SPARK_HOME /opt/spark
ENV CONDA_HOME /opt/conda
ENV PATH $PATH:$SPARK_HOME/bin:$CONDA_HOME/bin
ENV MESOS_NATIVE_JAVA_LIBRARY /usr/lib/libmesos.so

USER root

# Add Tini
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]
