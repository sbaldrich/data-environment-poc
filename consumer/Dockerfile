FROM anapsix/alpine-java:8_jdk_unlimited
MAINTAINER Santiago Baldrich <santiago.baldrich@gmail.com>

ADD consumer.zip /usr/local/consumer.zip

ENV CONSUMER_HOME=/usr/local/consumer

WORKDIR /usr/local

RUN unzip consumer.zip

RUN chmod +x $CONSUMER_HOME/bin/consumer

ADD start.sh /etc/start.sh

RUN chmod +x /etc/start.sh

ENTRYPOINT ["/etc/start.sh"]
