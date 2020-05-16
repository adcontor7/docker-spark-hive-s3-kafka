#!/bin/bash


HADOOP_VERSION=2.7.4
HIVE_VERSION=2.1.1
SPARK_VERSION=2.4.0

#docker build -f Dockerfile-ubuntu $1 -t kolt-ubuntu:latest .
#docker build -f Dockerfile-java8 $1 -t kolt-java8:latest .

docker build -f Dockerfile-hive-s3 $1 \
--build-arg HADOOP_VERSION=$HADOOP_VERSION \
--build-arg HIVE_VERSION=$HIVE_VERSION \
-t kolt-hive-s3:$HIVE_VERSION-$HADOOP_VERSION \
-t kolt-hive-s3:latest .

docker build -f Dockerfile-spark $1  \
--build-arg HADOOP_VERSION=$HADOOP_VERSION \
--build-arg HIVE_VERSION=$HIVE_VERSION \
--build-arg SPARK_VERSION=$SPARK_VERSION \
-t kolt-spark:$SPARK_VERSION \
-t kolt-spark:latest .

