FROM ubuntu:14.04
MAINTAINER Kostaintyn Bokhan <konstboh@gmail.com>

# Add image description and version
ENV IMAGE_DESCRIPTION spark-base
ENV IMAGE_VERSION 0.1
ENV SPARK_VERSION 1.6.1
ENV JAVA_VERSION 7
ENV MESOS_VERSION 0.28.0

# Configure corporate Debian proxy
# RUN echo 'Acquire::http::Proxy "http://106.125.32.200:3142/";' | sudo tee --append /etc/apt/apt.conf.d/30proxy

RUN apt-get remove -y --auto-remove openjdk* && \
    echo "deb http://repos.mesosphere.com/ubuntu trusty main" | sudo tee /etc/apt/sources.list.d/mesosphere.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
    apt-get update && \
    apt-get -y --download-only --no-install-recommends install mesos && \
    mkdir /tmp/mesos && \
    dpkg-deb -x /var/cache/apt/archives/mesos*.deb /tmp/mesos && \
    apt-get install -y --no-install-recommends \
    python \
    libnss3 \
    libsvn1 \
    openjdk-7-jre-headless \
    curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/oracle-jdk*

RUN cp /tmp/mesos/usr/lib/libmesos* /usr/lib/ && \
    rm -r -f /tmp/mesos/


RUN mkdir /opt/spark && \
    curl http://www-eu.apache.org/dist/spark/spark-1.6.1/spark-1.6.1-bin-hadoop2.6.tgz \
    | tar --strip-components=1 -xzC /opt/spark && \
    rm /opt/spark/lib/spark-examples-*.jar

RUN adduser -u 1001 --disabled-password --gecos "" worker

USER worker

ENV SPARK_HOME /opt/spark
ENV PATH $PATH:/opt/spark/bin
ENV MESOS_NATIVE_JAVA_LIBRARY /usr/lib/libmesos-0.28.0.so
