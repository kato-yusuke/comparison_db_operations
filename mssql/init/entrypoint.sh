#!/bin/bash

# SQL Serverをフォアグラウンドで実行
echo "Waiting for SQL Server to start..."
/opt/mssql/bin/sqlservr & MSSQL_PID=$!

# SQL Serverの起動を待機
while ! /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P P@ssw0rd -No -Q "SELECT 1" > /dev/null 2>&1; do
    sleep 1
done
echo "SQL Server started."

# 初期化用SQLを実行
echo "Initializing database..."
/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P P@ssw0rd -No -i /docker-initdb.d/init.sql
echo "Database initialized."

# バックグラウンドで実行中のSQL Serverのプロセスを待機
wait $MSSQL_PID
