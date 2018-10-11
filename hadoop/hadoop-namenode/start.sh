#!/bin/bash

echo -e "\n\e[00;37m*\e[00m `date` \e[00;37mStarting Supervisord\e[00m"
nohup /usr/bin/supervisord -c /etc/supervisord.conf &
echo "\e[33mWaiting for slave machines before starting cluster\[e0m"
sleep 5

echo -e "\n\e[01;37m*\e[00m `date` \e[01;37mStarting HDFS - NameNode DataNodes\e[00m"
start-dfs.sh

echo -e "\e[01;37m*\e[00m `date` \e[01;37mStarting YARN - Resource Manager\e[00m"
start-yarn.sh

$HADOOP_HOME/sbin/mr-jobhistory-daemon.sh start historyserver 2>/dev/null

echo -e "\e[01;37m*\e[00m \e[01;37mPreparing Hive\e[00m"

hadoop fs -mkdir -p /tmp
hadoop fs -mkdir -p /user/hive/warehouse
hadoop fs -chmod g+w /tmp
hadoop fs -chmod g+w /user/hive/warehouse

schematool -dbType postgres -initSchema

echo -e "\e[01;37m*\e[00m \e[01;37mStarting Hive Server\e[00m"
hiveserver2 &
hive --service metastore &
echo -e "\e[01;32m*\e[00m `date` \e[01;32mStarted Namenode\e[00m"
sleep 31536000 # sleep for a year so the process doesn't exit
