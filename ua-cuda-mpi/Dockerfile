FROM krot/ua-cuda-base:latest
MAINTAINER Kostaintyn Bokhan <konstboh@gmail.com> 

# Add image description and version
ENV IMAGE_DESCRIPTION ua-cuda-mpi
ENV IMAGE_VERSION 0.1

RUN apt-get update && apt-get install -y --no-install-recommends \
		openssh-server \
	&& rm -rf /var/lib/apt/lists/*


# passwordless ssh
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa && \
    cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

ADD ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config && \
    chown root:root /root/.ssh/config


# fix the 254 error code
RUN sed  -i "/^[^#]*UsePAM/ s/.*/#&/"  /etc/ssh/sshd_config
RUN echo "UsePAM no" >> /etc/ssh/sshd_config
RUN echo "Port 2122" >> /etc/ssh/sshd_config

# Install OpenMPI

RUN curl -s http://www.open-mpi.org/software/ompi/v1.10/downloads/openmpi-1.10.1.tar.gz | tar -xz -C /opt/
RUN cd /opt/openmpi-1.10.1 && ./configure --prefix=/opt/openmpi && make all install

ENV PATH $PATH:/opt/openmpi/bin
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/opt/openmpi/lib

EXPOSE 2122 

CMD ["/usr/sbin/sshd", "-D"]







