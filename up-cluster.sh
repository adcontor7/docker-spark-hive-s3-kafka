#!/bin/bash

if [ "$(docker images -q "kolt-spark:latest" 2> /dev/null)" == "" ]; then
    sh build-images.sh
    #sh build-images.sh --no-cache
fi

docker network create --driver=bridge --subnet=172.30.0.0/16 --ip-range=172.30.5.0/24 --gateway=172.30.5.254 shks3  || true

docker-compose up -d $1 portainer

##UP HIVE S3 SERVICE
#docker-compose up -d $1 hive-s3 # HIVE SERVICE ONLY
#docker cp conf/hive-site.xml $(docker-compose ps -q hive-s3):/opt/hive/conf/hive-site.xml

sleep 2

##UP SPARK SERVICE
docker-compose up -d $1 spark
docker cp conf/hive-site.xml $(docker-compose ps -q spark):/opt/spark/conf/hive-site.xml
docker cp conf/spark/log4j.properties $(docker-compose ps -q spark):/opt/spark/conf/log4j.properties

my_ip=`ip route get 1|awk '{print $NF;exit}'`
echo "Mysql Hive Metastore: http://${my_ip}:13306"
echo "S3: http://${my_ip}:10000"
echo "Spark: http://${my_ip}:8080"
echo "Zookeeper: http://${my_ip}:2181"
echo "Kafka: http://${my_ip}:9092"

