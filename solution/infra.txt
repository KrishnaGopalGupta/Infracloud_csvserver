Infracloud assignment:

Part1:
Run the container image infracloudio/csvserver:latest in background:

command: docker run -d --name csvserver infracloudio/csvserver:latest

Container is failing and check the logs of the container.

log check command:  docker logs csvserver

Error: 2022/02/08 10:36:04 error while reading the file "/csvserver/inputdata": open /csvserver/inputdata: no such file or directory


Write a bash script gencsv.sh to generate a file named inputFile with 10 entry:

#!/bin/bash
num=0

Random=$$

while [ $num -lt 10 ]
do
echo "$num,$Random"
num=`expr $num + 1`
done>inputFile


Run the container again in the background with file generated:

Command:  docker run -d  --name csvserver  -v $(pwd)/inputFile:/csvserver/inputdata/  infracloudio/csvserver:latest

Get shell access to the container and find the port on which the application is listening.

[root@master1 infracloud]# docker exec -it csvserver /bin/bash
[root@27b0f5835d18 csvserver]# netstat -nutlp
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp6       0      0 :::9300                 :::*                    LISTEN      1/csvserver


Once done, stop / delete the running container.

docker stop csvservervv ## Stop container
docker rm csvserver   ## Remove container


Run the container with port 9393 and set environment variable CSVSERVER_BORDER to have value Orange.
Command: docker run -d -p9393:9300 -e CSVSERVER_BORDER=Orange  --name csvserver  -v $(pwd)/inputFile:/csvserver/inputdata/  infracloudio/csvserver:latest

Part 2:

Delete any containers running from the last part.
docker rm -f csvserver


Create a docker-compose.yaml file for the setup from part I.

version: '3'
services:
  infracloud:
    image: infracloudio/csvserver
    ports:
    - 9393:9300
    environment:
      CSVSERVER_BORDER: Orange
    volumes:
    - ./inputFile:/csvserver/inputdata



run container using docker-compose:
docker-compose up 

Part 3:

created the Prometheus docker-compose yaml file and add the application:port in Prometheus yaml.
Prometheus is accesible at http://localhost:9090 on the host.
Type csvserver_records in the query box of Prometheus then switch to the Graph tab.

















