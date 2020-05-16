# Deploy Scality S3 + Hive Metastore + Spark + Kafka with Docker

Check build options. https://docs.docker.com/compose/reference/build/

Deploy First time
```
sh up.sh
```

Deploy changes
```
sh up.sh  --build --force-recreate
```

Start only
```
sh start-cluster.sh
```


Stop cluster
```
docker-compose stop
```

Destroy cluster
```
docker-compose rm -s -v -f
```


## Portainer (Manage Docker Infra.)

Go to Url http://localhost:9500


## Spark

Start Spark SQL shell
```
$ docker-compose exec spark /opt/spark/bin/spark-sql
  | use database1;
  | select count(*) from table1;
  | 1000

$ exit
```

To access the Spark web UI: [http://localhost:14040](http://localhost:14040).



## Hive

Start Hive CLI
```
$ docker-compose exec hive /opt/hive/bin/hive
```

Check the table out
```
use database1;
select count(*) from table1;
1000
```

## MySQL

The metastore database is called hive_metastore. It is lazily created when you first execute a Spark or Hive command.

Launch MySQL client
```
$ docker-compose exec mysql --password=mysecret
```

Run some interesting commands
```
show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| hive_metastore     |
| mysql              |
| performance_schema |
+--------------------+


use hive_metastore;

select * from  DBS;
+-------+-----------------------+--------------------------------------------+---------+------------+------------+
| DB_ID | DESC                  | DB_LOCATION_URI                            | NAME    | OWNER_NAME | OWNER_TYPE |
+-------+-----------------------+--------------------------------------------+---------+------------+------------+
|     1 | Default Hive database | file:/shared_data/hive/warehouse           | default | public     | ROLE       |
|     2 |                       | file:/shared_data/hive/warehouse/table1.db | table1  | NULL       | USER       |
+-------+-----------------------+--------------------------------------------+---------+------------+------------+

```


## Links of interest

* [AdminManual MetastoreAdmin](https://cwiki.apache.org/confluence/display/Hive/AdminManual+MetastoreAdmin) - Apache Hive wiki
  * [Metastore Entity Relationship Diagram](https://issues.apache.org/jira/secure/attachment/12471108/HiveMetaStore.pdf) - PDF download
* [Configuring the Hive Metastore for CDH](https://www.cloudera.com/documentation/enterprise/5-14-x/topics/cdh_ig_hive_metastore_configure.html) - CDH 5.14
* [Integrating Your Central Apache Hive Metastore with Apache Spark on Databricks](https://databricks.com/blog/2017/01/30/integrating-central-hive-metastore-apache-spark-databricks.html) - Jan. 2017
* [External Hive Metastore](https://docs.databricks.com/user-guide/advanced/external-hive-metastore.html) - Databricks documentation
* [Port of TPC-DS dsdgen to Java](https://github.com/starburstdata/tpcds)

