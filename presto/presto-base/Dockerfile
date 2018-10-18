FROM anapsix/alpine-java:8_jdk_unlimited
MAINTAINER Santiago Baldrich <santiago.baldrich@gmail.com>

ENV PATH=${PATH}:${JAVA_HOME}/bin:${JAVA_HOME}/sbin

RUN apk update && apk upgrade \
    && apk add openssh rsync curl procps supervisor vim bash ncurses bash-completion python3 \
    && pip3 install --upgrade pip \
    && pip install jinja2 \
    && rm -rf /var/cache/apk/*

ENV PRESTO_VERSION=0.212
ENV PRESTO_HOME=/usr/local/presto
ENV BASE_URL=https://repo1.maven.org/maven2/com/facebook/presto

WORKDIR /usr/local

RUN curl --remote-name ${BASE_URL}/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz

RUN tar -xzvf presto-server-${PRESTO_VERSION}.tar.gz

RUN ln -s /usr/local/presto-server-${PRESTO_VERSION} $PRESTO_HOME

ADD scripts ${PRESTO_HOME}/scripts

RUN mkdir -p $PRESTO_HOME/data
VOLUME ["$PRESTO_HOME/data"]
