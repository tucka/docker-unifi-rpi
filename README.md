# docker-unifi-rpi

Start docker with:

docker run -v /opt/unifi/data:/usr/lib/unifi/data --name unifi --net=host --restart=always -d unifi-rpi


