# MongoDB Sharded Cluster Deployment Running In Docker Containers

Provides the ability to execute a single command to build and run a MongoDB Sharded Cluster on a local workstation with each MongoDB component (`mongod`, `mongos`) running in a separate Docker container. Uses a [Docker](https://docs.docker.com/) [Compose](https://docs.docker.com/compose/overview/) project to launch the [sharded MongoDB cluster](https://docs.mongodb.com/manual/sharding/) containerised deployment consisting of 11 separate containers for:

  * 6 `mongod` processes for the 2 shard replica sets
  * 3 `mongod` processes for the _configdb_ replica set
  * 2 `mongos` router processes
  
All the containers are visible to each other on the same internal network. Once running, the MongoDB cluster is accessible directly from your workstation via the localhost forwarded ports 27107 & 27108 , which connect to each of the two mongos processes, respectively.

The first time you execute the command to build and run the containers, it takes a few minutes to download all the base Docker images. The containers will normally come up in less than 5 seconds when the command is executed the second and subsequent times.


## Prerequisites

* Your workstation is running a recent version of Linux, Windows or Mac OS X
* [Docker](https://docs.docker.com/install/) is already installed on your workstation
* [Docker Compose](https://docs.docker.com/compose/install/) is already installed on your workstation
* The [MongoDB Shell](https://docs.mongodb.com/mongodb-shell/install/) is already installed on your workstation for to you to issue commands to the running database cluster from your workstation (alternatively use the [MongoDB Compass](https://docs.mongodb.com/compass/current/install/) graphical tool to connect to the cluster)

_Note, this README assumes you are running version 2+ of Compose (e.g., `docker-compose-v2`) which integrates the `compose` action as an option when running the `docker` command. If you are running '1.x' version of Compose, for the commands shown in this README, swap `docker compose` with `docker-compose` (i.e., introduce a hyphen between the two words, replacing the space)._ 


## Build, Run & Connect

1. Launch a command line terminal in the base of folder of this project and execute the following command to build and start all the containers in the Docker Compose project:

```
docker compose up --build -d
```

2. Connect to the running MongoDB cluster from the MongoDB Shell (the shell will attempt to connect to the first of the two `mongos` endpoints) and then issue the command to print the states of the sharded cluster:

```
mongosh --port 27017
```

```
sh.status()
```

_Note_: Use port 27018 instead, above, if you want to connect to the second `mongos` endpoint.


## Tips

* To show all the running docker containers for this Docker Compose project, run:

```
docker compose ps
```

* To show the container logs for one of the `mongos` routers, run:

```
docker compose logs mongos-router0
```

* To execute a terminal session directly in one of the `mongos` containers, to then invoke the MongoDB Shell directly accessing the local `mongos` process, run:

```
docker compose exec mongos-router0 /bin/bash
```

```
mongosh
```

* To execute a terminal session directly in one of the `mongod` containers and then view the `mongod` process logs, run:

```
docker compose exec shard0-replica0 /bin/bash
```

```
cat /data/db/mongod.log
```

* To shutdown and remove all the Docker Compose project's running containers (ready for you to rebuild and run again), run:

```
docker compose down
```
