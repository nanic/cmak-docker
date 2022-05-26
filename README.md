# CMAK Docker Setup

CMAK is a tool for managing Kafka cluster(s). This repository creates a docker image for running CMAK as a container. The actual CMAK repository is located [here](https://github.com/yahoo/CMAK).

## How to build the image:

```sh
$ docker build --build-arg CMAK_VERSION="3.0.0.5" -t <image-tag> .
```

You can also pass in `ZK_HOSTS` & `CMAK_CONFIGFILE` as build time arguments.


> I have also added docker-compose and kubernetes deployment files for helping to set up a simple local kafka setup along with CMAK.

* For docker-compose

```sh
$ cd docker-compose/
$ docker-compose up -d
```
hit `localhost:9000` in browser of your choice for accessing CMAK.

* For kubernetes

```sh
$ cd kubernetes/
$ kubectl apply -f zookeeper.yaml 
$ kubectl apply -f kafka.yaml
$ kubectl apply -f cmak.yaml
```

hit `localhost:30090` in browser of your choice for accessing CMAK.

**Note: We are using different port in case of kubernetes setup because of Kubernetes Service(NodePort) setup in k8s cluster.**
