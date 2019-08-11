#!/bin/bash
set -e

cat >> ${PGDATA}/postgresql.conf <<EOF

## Replication config ##

wal_level = hot_standby
max_wal_senders = 8
wal_keep_segments = 8
hot_standby = on

EOF

until PGPASSWORD=$PG_REP_PASSWORD psql -h pgmaster -U $PG_REP_USER -d postgres -c '\q'; do
  >&2 echo "Master is not ready yet, sleeping for a second..."
  sleep 1
done

pg_ctl -D "$PGDATA" -m fast stop
# make sure standby's data directory is empty
rm -r "$PGDATA"/*

pg_basebackup \
    --write-recovery-conf \
    --pgdata="$PGDATA" \
    --username=$PG_REP_USER \
    --host=pgmaster \
    --port=5432 \
    --progress \
    --verbose

# The Docker entrypoint expects to have a running server
pg_ctl -D "$PGDATA" start
