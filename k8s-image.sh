#!/bin/bash
//版本号需要指定
K8S_VER=v1.14.1
ETCD_VER=3.3.10
PAUSE_VER=3.1
DNS_VER=1.3.1
FLANNEL_VER=v0.11.0
DASHBOARD_VER=v1.10.1

yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce
systemctl start docker
systemctl enable docker


docker pull k8s.gcr.io/kube-apiserver:$K8S_VER
docker pull k8s.gcr.io/kube-controller-manager:$K8S_VER
docker pull k8s.gcr.io/kube-scheduler:$K8S_VER
docker pull k8s.gcr.io/kube-proxy:$K8S_VER
docker pull k8s.gcr.io/etcd:$ETCD_VER
docker pull k8s.gcr.io/pause:$PAUSE_VER
docker pull k8s.gcr.io/coredns:$DNS_VER
docker pull quay.io/coreos/flannel:$FLANNEL_VER-amd64
docker pull k8s.gcr.io/kubernetes-dashboard-amd64:$DASHBOARD_VER

docker save $(docker images | grep -v REPOSITORY | awk 'BEGIN{OFS=":";ORS=" "}{print $1,$2}') -o k8s-master-v1.14.1.tar
docker save k8s.gcr.io/kube-proxy:v1.14.1 quay.io/coreos/flannel:v0.11.0-amd64 k8s.gcr.io/pause:3.1 -o k8s-node-v1.14.1.tar
