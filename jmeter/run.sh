  
#!/bin/bash
#
# Run JMeter Docker image with options

echo "Iniciando JMeter Docker Image"
NAME="jmetertest"
IMAGE="justb4/jmeter:latest"
ROOTPATH=$1

echo "$ROOTPATH"
# Finally run
echo "Docker STOP..."
docker stop $NAME > /dev/null 2>&1
echo "Docker RM..."
docker rm $NAME > /dev/null 2>&1
echo "Docker RUN..."
docker run --name $NAME -i -v $ROOTPATH:/test -w /test $IMAGE ${@:2}