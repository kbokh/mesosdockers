
## CUDNN-SPARK

This dockerfile is destined for research and development of machine learning technologies especially deep learning. It can be use with mesos cluster.
cudnn-spark is based on nvidia/cuda:cudnn and consists of spark

### Requirements

- CUDA drivers
    - Minimum driver version: >= 352.39
    - Minimum GPU architecture: >= 2.0 (Fermi)
- [nvidia-docker](https://github.com/NVIDIA/nvidia-docker/wiki/Using-nvidia-docker)
- [nvidia-docker-plugin](https://github.com/NVIDIA/nvidia-docker/wiki/Using-nvidia-docker-plugin)
- mesos cluster >= 0.28

### Usage

#### Local - spark-submit
```
nvidia-docker run --net host kbokh/cudnn-spark spark-submit --master mesos://<mesos-master-host>:<port> --deploy-mode client --conf spark.mesos.executor.docker.image=kbokh/cudnn-spark --class <main-class> /<app-jar>
```
  where <main-class> /<app-jar> is a spark application

#### Local - spark-shell
```
nvidia-docker run --net host kbokh/cudnn-spark spark-shell
```

#### Remote - marathon
```
TODO - Add marathon json
```
