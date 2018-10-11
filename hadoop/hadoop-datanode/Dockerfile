FROM sbaldrich/hadoop-base
MAINTAINER Santiago Baldrich <santiago.baldrich@gmail.com>

ENV SQOOP_VERSION 1.4.7
RUN curl https://www-us.apache.org/dist/sqoop/${SQOOP_VERSION}/sqoop-${SQOOP_VERSION}.bin__hadoop-2.6.0.tar.gz | tar -xzf - -C /usr/local/ \
    && ln -s /usr/local/sqoop-${SQOOP_VERSION}.bin__hadoop-2.6.0/ /opt/sqoop

ENV SQOOP_HOME=/opt/sqoop
ENV PATH=$PATH:$SQOOP_HOME/bin

RUN curl https://jdbc.postgresql.org/download/postgresql-42.2.5.jar -o /opt/sqoop/lib/postgresql-42.2.5.jar

RUN ln -s $HIVE_HOME/lib/hive-exec-${HIVE_VERSION}.jar $SQOOP_HOME/lib/hive-exec.jar

ADD start.sh /etc/start.sh
RUN chmod +x /etc/start.sh \
    && mkdir -p /tmp/hdfs/datanode

# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 8020 9000

# Mapred ports
EXPOSE 10020 19888

# Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088


ENTRYPOINT ["/etc/start.sh", "bash"]
