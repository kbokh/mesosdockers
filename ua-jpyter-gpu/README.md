
## SRK-Jupyter-gpu

This dockerfile is destined for research and development of deep learning technologies especially for a mesos cluster.
SRK-Jupyter-gpu integartes jupyter web application, cuda, spark and can be connected to a mesos cluster. SRK-Jupyter-gpu consists of:
- debian
- cuda 7.5.18
- miniconda
- bokeh
- lasagne
- theano
- SPARK
- mesos
- jupyter

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
"id": "jupyter-job",
    "container": {
        "docker": {
            "image": "krot/srk-jupyter-gpu",
            "forcePullImage": true,
            "privileged": true,
            "network": "BRIDGE",
            "portMappings": [ 
                { "containerPort": 8888, "hostPort": 0, "servicePort": 0, "protocol": "tcp" } 
            ]
            "volumes": [
                {
                    "containerPath": "/home/spworker/work",
                    "hostPath": "/mnt/projects/[.ipynb folder]",
                    "mode": "RW"
                }
            ]
        },        
        "type": "DOCKER"
    },
    "constraints": [
    ]
    "env": { "PORT": "8888" },
    "cpus": 8.0,
    "mem": 12000.0,
    "gpu": 1.0,
    "instances": 1    
}
```
*Comments.* 
- Mesos custom resources like "gpu" are not supported by marathon and other mesos frameworks yet. 
- Change path .ipynb folder to proper project folder
- jupyter interface can be reached using marathon. Just go to marathon web interface, open task with ID that you just created. ID column consists of link to jupyter interface.
