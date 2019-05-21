# Example Containerised MongoDB Sharded Cluster Project

A project requiring a single command to build and run a MongoDB Sharded Cluster in a local laptop/PC environment with each MongoDB component (_Mongod_, _Mongos_) running in a separate Docker container. Uses a [Docker](https://docs.docker.com/) [Compose](https://docs.docker.com/compose/overview/) project to launch the sharded [MongoDB cluster](https://docs.mongodb.com/manual/sharding/) containerised deployment.

Each element in the deployment topology (9 _Mongod_ processes for the 2 shard replica sets and the _configdb_ replica set + 2 _Mongos_ processes) runs in its own Docker container and all the containers are visible to each other on the same _internal_ network. Once running, the MongoDB cluster is accessible directly from your laptop/PC, via localhost forwarded ports 27107 & 27108 which connect to each of the two Mongos processes respectively.

# Prerequisites
* Your laptop/PC is running a recent version of Linux, Windows or Mac OS X
* [Docker](https://docs.docker.com/install/) is already installed on your laptop/PC
* [Docker Compose](https://docs.docker.com/compose/install/) is already installed on your laptop/PC
* [MongoDB](https://docs.mongodb.com/manual/installation/) is already installed on your laptop/PC to enable the Mongo Shell to be run directly from your laptop/PC (alternatively use MongoDB Compass to connect to the cluster)

# Build, Run & Connect
1. Launch a command line terminal in the base _sharded-mongodb-docker_ folder and execute the following command to build and start all the containers in the Docker Compose project:
```
sudo docker-compose up --build -d
```
2. Show all the running docker containers for this Docker Compose project:
```
sudo docker-compose ps
```
3. Connect to the MongoDB cluster from the Mongo Shell (the Shell should connect to the first of the two Mongos endpoints):
```
mongo --port 27017
sh.status()
exit
```
_Note_: Use port 27018 instead, above, if you want to connect to the second Mongos.

# Tips
* To show the container logs for one of the Mongos servers, run:
```
sudo docker-compose logs mongos-router0
```
* To execute a terminal session directly in one of the Mongos containers and then execute the Mongo Shell directly accessing the local Mongos process, run:
```
sudo docker-compose exec mongos-router0 /bin/bash
mongo
```
* To execute a terminal session directly in one of the Mongod containers and then view the Mongod process' logs, run:
```
sudo docker-compose exec shard0-replica0 /bin/bash
cat /data/db/mongod.log
```
* To shutdown and remove all the Docker Compose project's running containers (ready for you to rebuild and run again), run:
```
sudo docker-compose down
```

