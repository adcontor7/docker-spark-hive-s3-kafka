#!/bin/bash
if [ -z ${S3_ACCESS_KEY_ID+x} ] || [ -z ${S3_SECRET_ACCESS_KEY+x} ] ; then
  echo "AWS_ACCESS_KEY_ID || AWS_SECRET_ACCESS_KEY  not setted"
else
  HDFS_SITE="
    <configuration>
      <property>
        <name>fs.s3a.access.key</name>
        <value>$S3_ACCESS_KEY_ID</value>
      </property>
      <property>
        <name>fs.s3a.secret.key</name>
        <value>$S3_SECRET_ACCESS_KEY</value>
      </property>
    </configuration>
  "
  echo "$HDFS_SITE" > $HADOOP_CONF_DIR/hdfs-site.xml
fi
