FROM sbaldrich/hadoop-base
MAINTAINER Santiago Baldrich <santiago.baldrich@gmail.com>

RUN hdfs namenode -format
WORKDIR /home/root

# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 8020 9000

# Mapred ports
EXPOSE 10020 19888

# Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088

# Hive ports
EXPOSE 10000 10001 10002

#Other ports
EXPOSE 49707 22 2122

ADD start.sh /etc/start.sh
RUN chmod +x /etc/start.sh

ENTRYPOINT ["/etc/start.sh", "bash"]
