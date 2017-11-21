FROM ubuntu:16.04
MAINTAINER Kwanki Ahn(kwanki.ahn@samsung.com)
RUN apt-get update
RUN apt-get -y install apt-transport-https
#RUN apt-get -y install redis-server
RUN apt-get -y install redis-sentinel
RUN mkdir -p /redis
WORKDIR /redis
ADD start.sh /redis/
ADD sentinel.conf /redis/
RUN chmod +x /redis/start.sh
ENTRYPOINT /redis/start.sh
EXPOSE 26379
