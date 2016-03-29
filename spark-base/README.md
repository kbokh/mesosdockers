
## SPARK-BASE

This dockerfile is destined for research and development of machine learning technologies especially deep learning. It can be use with a mesos cluster.
spark-base image is aimed to use as a base image for other spark-based images

### Requirements

- mesos cluster >= 0.28
- latest docker image on all mesos slaves

### Usage

#### Client mode
```
docker run -ti -u worker --net host kbokh/spark-base pyspark \
       --master mesos://zk://<zookeeperhost>:2181/mesos \
       --conf spark.mesos.executor.docker.image=kbokh/spark-base \
       --conf spark.mesos.mesosExecutor.cores=<num of cores> \
       --conf spark.mesos.coarse=false \
       --conf spark.mesos.executor.docker.volumes=/var/lib/mesos:/var/lib/mesos:rw
```
#### Cluster mode


TODO - Add cluster mode usage


#### Remote - marathon
```
TODO - Add marathon json
```
