#!/bin/bash

# the default node number is 5
N=${1:-5}


# start hadoop master container
sudo docker rm -f hadoop-master &> /dev/null
echo "start hadoop-master container..."
sudo docker run -itd \
                --net=hadoop \
                -p 50070:50070 \
                -p 8088:8088 \
                -p 9000:9000 \
                -p 9001:9001 \
                -p 8032:8032 \
                -p 10020:10020 \
                -p 14000:14000 \
                --name hadoop-master \
                --hostname hadoop-master \
                wentaoma/hadoop:2.7.2 &> /dev/null


# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f hadoop-slave$i &> /dev/null
	echo "start hadoop-slave$i container..."
	sudo docker run -itd \
	                --net=hadoop \
	                --name hadoop-slave$i \
	                --hostname hadoop-slave$i \
	                wentaoma/hadoop:2.7.2 &> /dev/null
	i=$(( $i + 1 ))
done 

# get into hadoop master container
sudo docker exec -it hadoop-master bash
