#!/bin/bash

file="/docker-entrypoint-initdb.d/mydb_dump.pgdata"
username=myuser
dbname=mydb


echo "Creating additional users"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER $username;
    CREATE DATABASE $dbname;
    GRANT ALL PRIVILEGES ON DATABASE $dbname TO $username;
EOSQL

echo "Restoring DB using $file"
pg_restore -U postgres --dbname=$dbname --verbose --single-transaction < "$file" || exit 1
