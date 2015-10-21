
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

#### Standalone
```
docker run -it --device /dev/nvidiactl --device /dev/nvidia-uvm --device /dev/nvidia0 krot/srk-lasagne
docker run -it --device /dev/nvidiactl --device /dev/nvidia-uvm --device /dev/nvidia0 --device /dev/nvidia1 ... --device /dev/nvidia# krot/srk-lasagne 
```
  where # is number of the NVIDIA device

#### For greater performance, you can also install cuDNN.
  - Download from the cuDNN website
  - Unpack cuDNN in somewhere on the host, e.g. /home/user/cudnn
  - Map the files directly into your container using -v docker option

```
-v /home/user/cudnn/libcudnn.so:/usr/local/cuda/lib64/libcudnn.so:ro \
-v /home/user/cudnn/libcudnn.so.7.0:/usr/local/cuda/lib64/libcudnn.so.7.0:ro \
-v /home/user/cudnn/libcudnn.so.7.0.64:/usr/local/cuda/lib64/libcudnn.so.7.0.64:ro \
-v /home/user/cudnn/libcudnn_static.a:/usr/local/cuda/lib64/libcudnn_static.a:ro \
-v /home/user/cudnn/cudnn.h:/usr/local/cuda/include/libcudnn_static.a:ro \

```
#### Example of a marathon json for mesos
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
