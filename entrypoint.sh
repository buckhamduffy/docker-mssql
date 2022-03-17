#!/bin/bash

MSSQL_SA_PASSWORD=$SA_PASSWORD /opt/mssql/bin/mssql-conf set-sa-password

# Start the script to create the DB and user
/usr/config/configure-db.sh &

# Start SQL Server
/opt/mssql/bin/sqlservr

