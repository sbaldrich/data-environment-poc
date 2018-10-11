#!/bin/bash
set -e

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
EOSQL
