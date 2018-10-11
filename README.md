## Data Environment cluster

Simple data infrastructure environment built with `docker` and `docker-compose`.

The environment is composed by:

* [Hadoop](https://hadoop.apache.org/)
* [Hive](https://hive.apache.org/)
* [PrestoDB](https://prestodb.io/)
* [PostgreSQL](https://www.postgresql.org/)
* [Sqoop](https://sqoop.apache.org/)

### Building

Just run `make build` and the project will take care of building the required images.

### [Building and] Running

`make` will build everything necessary and use `docker-compose` to deploy the environment.

### Proof of Concept

* Start the environment

* The postgres database is initialized with two tables that represent a soccer tournament, one for Teams and another for Matches. See [setupdb.sh](https://github.com/sbaldrich/data-environment-poc/blob/master/conf/postgres/setupdb.sh)

* During deployment, one of the hadoop datanodes will use `sqoop` to import the Matches table into hive. See the [hadoop-datanode startup script](https://github.com/sbaldrich/data-environment-poc/blob/master/hadoop/hadoop-datanode/start.sh)

* Run the `sbaldrich/presto-consumer-example` image making sure to attach it to the network that was created by compose. Notice that the url of the presto coordinator is given as argument to the execution of the image.
```
docker run -it --network data-environment_default sbaldrich/presto-consumer-example jdbc:presto://coordinator:8080
```

* The `sbaldrich/presto-consumer-example` image contains a simple java application that will run a [SQL script](https://github.com/sbaldrich/data-environment-poc/blob/master/consumer/src/main/resources/query.sql) that consumes and joins data from different data sources (postgres and hive) and joins it to produce a result.

### Acknowledgements

Thanks to [Lewuathe](https://github.com/Lewuathe/), the owner of the [docker-presto-cluster](https://github.com/Lewuathe/docker-presto-cluster) code on which this project is heavily based.
