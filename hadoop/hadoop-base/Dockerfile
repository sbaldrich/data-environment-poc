FROM anapsix/alpine-java:8_jdk_unlimited
MAINTAINER Santiago Baldrich <santiago.baldrich@gmail.com>

ENV PATH=${PATH}:${JAVA_HOME}/bin:${JAVA_HOME}/sbin

RUN apk update && apk upgrade \
    && apk add openssh rsync curl procps supervisor vim bash ncurses bash-completion \
    && rm -rf /var/cache/apk/*

# SSH Key Passwordless
RUN /usr/bin/ssh-keygen -A \
    && ssh-keygen -q -N "" -t rsa -f /etc/ssh/id_rsa \
    && cp /etc/ssh/id_rsa.pub /etc/ssh/authorized_keys
RUN mkdir -p /root/.ssh \
    && cp /etc/ssh/ssh_config /root/.ssh/config \
    && cp /etc/ssh/authorized_keys /root/.ssh/authorized_keys \
    && cp /etc/ssh/id_rsa /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh \
    && chmod 600 /root/.ssh/config \
    && chmod 600 /root/.ssh/id_rsa \
    && chmod 600 /root/.ssh/authorized_keys
RUN sed -i '/StrictHostKeyChecking/s/ask/no/g' /etc/ssh/ssh_config \
    && sed -i '/StrictHostKeyChecking/s/#//g' /etc/ssh/ssh_config

# Supervidor
ADD supervisord.conf /etc/supervisord.conf

# glibc
ENV GLIB_VERSION 2.25-r0
RUN apk --update add ca-certificates \
    && curl -Ls https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIB_VERSION}/glibc-${GLIB_VERSION}.apk > /tmp/glibc-${GLIB_VERSION}.apk \
    && apk add --allow-untrusted /tmp/glibc-${GLIB_VERSION}.apk

# Hadoop
ENV HADOOP_VERSION 2.8.5
RUN curl http://www-eu.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar -xzf - -C /usr/local/ \
    && rm -fR /usr/local/hadoop-${HADOOP_VERSION}/share/doc \
              /usr/local/hadoop-${HADOOP_VERSION}/share/hadoop/common/jdiff \
    && ln -s /usr/local/hadoop-${HADOOP_VERSION}/ /opt/hadoop
ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_INSTALL=$HADOOP_HOME
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV YARN_HOME=$HADOOP_HOME
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

# Configurations
ADD hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh
ADD core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
ADD hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
ADD mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml
ADD yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml

# Hive
ENV HIVE_VERSION 2.3.3
RUN curl https://www-eu.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz | tar -xzf - -C /usr/local/ \
    && ln -s /usr/local/apache-hive-${HIVE_VERSION}-bin/ /opt/hive

ENV HIVE_HOME=/opt/hive
ENV HIVE_CONF_DIR=$HIVE_HOME/conf
ENV PATH=$PATH:$HIVE_HOME/bin

EXPOSE 10000 10001 10002
