# Use the official HiveMQ Docker image as the base image
FROM hivemq/hivemq-ce
# For Enterprise Edition use the following base image
# FROM hivemq/hivemq4

# Copy custom configuration files into the container
COPY config.xml /opt/hivemq/conf/config.xml

# Expose MQTT, Websocket, and clustering ports
# EXPOSE 1883 8000 7800
USER root
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y apt-transport-https

# Install Nginx for reverse proxy
RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

COPY nginx.conf /etc/nginx/nginx.conf

# Expose Nginx HTTP port
EXPOSE 80

CMD service nginx start && /opt/hivemq/bin/run.sh
