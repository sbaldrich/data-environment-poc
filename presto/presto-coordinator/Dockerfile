FROM sbaldrich/presto-base:latest
MAINTAINER Santiago Baldrich <santiago.baldrich@gmail.com>

ADD etc /usr/local/presto/etc

EXPOSE 8080

WORKDIR /usr/local/presto
ARG node_id
RUN python3 scripts/render.py --node-id $node_id etc/node.properties.template

CMD ["./bin/launcher", "run"]
