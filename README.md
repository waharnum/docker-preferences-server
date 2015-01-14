## GPII Preferences Server Dockerfile


This repository is used to build [GPII Preferences Server](http://wiki.gpii.net/w/Architecture_Overview#Preferences_Server) Docker images.

### Port(s) Exposed

    8082 TCP

### Environment Variables

The following environment variables can be used to affect the container's behaviour:

    NODE_ENV

`NODE_ENV` should most likely be set to `preferencesServer.production` unless you would like to test more customized deployments.

    COUCHDB_HOST_ADDRESS

This allows the Preferences Server process to reach a CouchDB instance. An IPv4 address is expected.

    PRIME_DB

If this is the first time the Preferences Server is being deployed then you will want to use `PRIME_DB=yes` so that default [test preferences](https://github.com/GPII/universal/tree/master/testData/preferences) can be modified and uploaded to CouchDB.

Please scroll down for a complete example on how to start this container.

### Base Docker Image

* [gpii/universal](https://github.com/gpii-ops/docker-universal/)


### Download

    docker pull gpii/preferences-server

#### Run `preferences-server`

If your CouchDB instance uses a `10.0.2.15` IP address you could start a container like this:

```
docker run \
-it \
--rm=true \
-p 8082:8082 \
-e PRIME_DB=yes \
-e COUCHDB_HOST_ADDRESS=10.0.2.15 \
-e NODE_ENV=preferencesServer.production \
gpii/preferences-server
```

### Build your own image

    docker build --rm=true -t gpii/preferences-server .
