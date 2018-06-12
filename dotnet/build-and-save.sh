IMAGE=dotnet-krb:2.1.0-aspnetcore-runtime-alpine
DESTINATION_FILE=/tmp/`echo $IMAGE | tr : _`.tar
sudo docker build . -t $IMAGE
sudo docker save $IMAGE > $DESTINATION_FILE
gzip -fv $DESTINATION_FILE
