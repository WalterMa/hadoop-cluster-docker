## Run Hadoop Cluster within Docker Containers

- Blog: [Run Hadoop Cluster in Docker Update](http://kiwenlau.com/2016/06/26/hadoop-cluster-docker-update-english/)
- 博客: [基于Docker搭建Hadoop集群之升级版](http://kiwenlau.com/2016/06/12/160612-hadoop-cluster-docker-update/)


![alt tag](https://raw.githubusercontent.com/kiwenlau/hadoop-cluster-docker/master/hadoop-cluster-docker.png)


### Prerequisites

Need docker be installed and configured to use [Device Mapper](https://docs.docker.com/engine/userguide/storagedriver/device-mapper-driver/) diver first

https://docs.docker.com/engine/userguide/storagedriver/device-mapper-driver/

Device Mapper driver is used to limit each container storge size, if you just want to try this repo, you can comment these lines in start-container.sh:

```
--storage-opt size=10G
```


### 5 Nodes Hadoop Cluster

##### 1. pull docker image

```
sudo docker pull wentaoma/hadoop:2.7.2
```

##### 2. clone github repository

```
git clone https://github.com/WalterMa/hadoop-cluster-docker.git
```

##### 3. create hadoop network

```
sudo docker network create --driver=bridge hadoop
```

##### 4. start container

```
cd hadoop-cluster-docker
sudo ./start-container.sh
```

**output:**

```
start hadoop-master container...
start hadoop-slave1 container...
start hadoop-slave2 container...
start hadoop-slave3 container...
start hadoop-slave4 container...
root@hadoop-master:~# 
```
- start 3 containers with 1 master and 4 slaves
- you will get into the /root directory of hadoop-master container

##### 5. start hadoop

```
./start-hadoop.sh
```

- start hadoop services include httpfs

##### 6. run wordcount

```
./run-wordcount.sh
```

**output**

```
input file1.txt:
Hello Hadoop

input file2.txt:
Hello Docker

wordcount output:
Docker    1
Hadoop    1
Hello    2
```

### Arbitrary size Hadoop cluster

##### 1. pull docker images and clone github repository

do 1~3 like section A

##### 2. rebuild docker image

```
sudo ./resize-cluster.sh 3
```
- specify parameter > 1: 2, 3..
- this script just rebuild hadoop image with different **slaves** file, which pecifies the name of all slave nodes


##### 3. start container

```
sudo ./start-container.sh 3
```
- use the same parameter as the step 2

##### 4. run hadoop cluster 

do 5~6 like section A


### How to connect to remote hadoop and commit job in Intellij ?

Please see this repo: 
https://github.com/WalterMa/hadoop-intellj-example
