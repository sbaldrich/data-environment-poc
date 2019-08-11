#!/bin/bash
set -e

mkdir -p /var/lib/postgresql/10/main/base/mnt/server/archivedir

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE USER hiveuser WITH PASSWORD 'hive';
  CREATE DATABASE metastore WITH OWNER hiveuser;
  CREATE TABLE teams (
    team_id serial primary key,
    team_name varchar(20)
  );

  CREATE TABLE matches(
    home_id int references teams (team_id),
    away_id int references teams (team_id),
    home_goals int,
    away_goals int
  );

  INSERT INTO teams(team_name) values('BRA'), ('COL'), ('MEX'), ('SWE'), ('NED');
  INSERT INTO matches values (1,2,1,1), (1,3,0,3), (2,3,1,0);

  CREATE USER $PG_REP_USER REPLICATION LOGIN CONNECTION LIMIT 100 ENCRYPTED PASSWORD '$PG_REP_PASSWORD';
EOSQL

cat >> ${PGDATA}/postgresql.conf <<EOF

## Replication config ##

wal_level = hot_standby
max_wal_senders = 8
wal_keep_segments = 8
hot_standby = on

EOF

echo "host replication $PG_REP_USER 0.0.0.0/0 trust" >> "$PGDATA/pg_hba.conf"
