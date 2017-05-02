FROM resin/rpi-raspbian:jessie

# ENV INITSYSTEM on

# Add Unifi to sources.list
RUN echo "deb http://www.ubnt.com/downloads/unifi/debian unifi5 ubiquiti" > /etc/apt/sources.list.d/ubiquiti.list

# Install Unifi GPG Key
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50

# Update and Upgrade
RUN apt-get update && \
    apt-get upgrade

RUN apt-get install rpi-update && echo Y | sudo rpi-update

# Install Oracle Java 8
RUN apt-get install oracle-java8-jdk -y

# Install Unifi
RUN apt-get install -qy --force-yes --no-install-recommends unifi wget

# Install Snappy Java patch
RUN cd /usr/lib/unifi/lib  && \
	rm snappy-java-1.0.5.jar  && \
	wget http://central.maven.org/maven2/org/xerial/snappy/snappy-java/1.1.2.6/snappy-java-1.1.2.6.jar && \
	ln -s snappy-java-1.1.2.6.jar snappy-java-1.0.5.jar

RUN ln -s /opt/UniFi /usr/lib/unifi

# Cleanup
RUN apt-get -q clean && \
    rm -rf /var/lib/apt/lists/*


#Expose Ports
EXPOSE 6789/tcp 8080/tcp 8081/tcp 8443/tcp 8843/tcp 8880/tcp 3478/udp

VOLUME /usr/lib/unifi/data
WORKDIR /var/lib/unifi

CMD ["java", "-Xmx256M", "-jar", "/usr/lib/unifi/lib/ace.jar", "start"]
