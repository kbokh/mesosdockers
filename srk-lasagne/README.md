
## SRK-Lasagne

This dockerfile is destined for research and development of machine learning technologies especially deep learning. It can be use with mesos cluster.
SRK-lasagne is based on:
- debian
- cuda 7.5.18
- miniconda
- bokeh
- lasagne
- theano

### Requirements

- CUDA drivers should be installed for the kernel module on the host using binary package (not deb).

### Usage

One or more NVIDIA devices should be attached to the container

1. Standalone

- docker run -it --device /dev/nvidiactl --device /dev/nvidia-uvm --device /dev/nvidia0 krot/srk-lasagne
- docker run -it --device /dev/nvidiactl --device /dev/nvidia-uvm --device /dev/nvidia0 --device /dev/nvidia1 ... --device /dev/nvidia# krot/srk-lasagne 
  where # is number of the NVIDIA device

2. Example of a marathon json for mesos
```
{
    "id": "rnn-53",
    "container": {
        "docker": {
            "image": "krot/srk-lasagne",
            "forcePullImage": true,
            "privileged": true
        },
        "type": "DOCKER",
        "volumes": [
          {
           "containerPath": "/data",
           "hostPath": "/mnt/data/repl/rnn",
           "mode": "RW"
          }
       ]
    },
    "args": ["/bin/sh", "-c", "/data/run.sh"],
    "cpus": 4.0,
    "mem": 4000.0,
    "gpu": 1.0,
    "instances": 1
}
```
*Comments.* Mesos custom resources like "gpu" are not supported by marathon and other mesos frameworks yet. 
