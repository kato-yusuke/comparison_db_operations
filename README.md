# DB動作比較検証

## 比較対象

|DBサーバ|バージョン|
|-|-|
|MySQL|8.4|
|MariaDB|11.8|
|PostgreSQL|17.9|
|Microsoft SQL Server|2022|

## 今回やる事

 contents

- Dockerで構築する（最低限の設定のみ）
- DB接続方法
- 便利コマンド
- テーブル作成
- インデックスによる動作速度の違い（MySQL）

## Dockerで構築する（最低限の設定のみ）

docker-compose.ymlを参照

### Docker起動方法

```bash
{ docker-compose down; docker-compose build; docker-compose up -d; }
```

## DB接続方法

- MySQL

    ```bash
    docker-compose exec mysql mysql -h {host} -P {port} -u {user} -p{password} {db_name}
    docker-compose exec mysql mysql -h localhost -P 3306 -u db_user -pP@ssw0rd test_db
    ```

- MariaDB

    ```bash
    docker-compose exec mariadb mariadb -h {host} -P {port} -u {user} -p{password} {db_name}
    docker-compose exec mariadb mariadb -h localhost -P 3306 -u db_user -pP@ssw0rd test_db
    ```

- PostgreSQL

    ```bash
    docker-compose exec postgresql psql -h {host} -p {port} -U {user} -d {db_name}
    docker-compose exec postgresql psql -h localhost -p 5432 -U db_user -d test_db
    ```

- Microsoft SQL Server

    ```bash
    docker-compose exec mssql /opt/mssql-tools18/bin/sqlcmd -No -S {host},{port} -U {user} -P {password} -d {db_name}
    docker-compose exec mssql /opt/mssql-tools18/bin/sqlcmd -No -S localhost,1433 -U sa -P P@ssw0rd -d test_db
    ```

## 便利コマンド

- MySQL

    ```sql
    -- データベースの一覧を表示
    SHOW DATABASES;

    -- データベースの選択
    USE {db_name}
    USE test_db

    -- テーブルの一覧を表示
    SHOW TABLES;

    -- テーブルの構造を表示
    DESC {table_name};
    DESC test_table_1;

    -- テーブルのクリエイト文を表示
    SHOW CREATE TABLE {table_name};
    SHOW CREATE TABLE test_table_1;

    -- テーブルのインデックス情報を表示
    SHOW INDEX FROM {table_name};
    SHOW INDEX FROM test_table_1;

    -- 実行中プロセスの一覧を表示
    SHOW PROCESSLIST;

    -- プロセスの停止
    KILL {process_id};
    ```

- MariaDB

    ```sql
    SHOW DATABASES;
    ```

- PostgreSQL

    ```sql
    -- データベースの一覧を表示
    \l

    -- データベースの選択
    \c {db_name}
    \c test_db

    -- テーブルの一覧を表示
    \dt

    -- ビューの一覧を表示
    \dv

    -- テーブルの構造を表示
    \d {table_name}
    \d test_table_1

    -- テーブルのクリエイト文を表示
    SHOW CREATE TABLE {table_name};
    SHOW CREATE TABLE test_table_1;

    -- テーブルのインデックス情報を表示
    SELECT * FROM pg_indexes WHERE tablename = '{table_name}';
    SELECT * FROM pg_indexes WHERE tablename = 'test_table_1';

    -- 実行中プロセスの一覧を表示
    SELECT * FROM pg_stat_activity;

    -- プロセスの停止（実行の取消：セッションは有効なまま）
    SELECT pg_cancel_backend({process_id});

    -- プロセスの停止（実行の削除：セッションも切断する）
    SELECT pg_terminate_backend({process_id});
    ```

- Microsoft SQL Server

    ```sql
    -- データベースの一覧を表示
    SELECT name FROM sys.databases;

    -- データベースの選択
    USE {db_name};
    USE test_db;

    -- テーブル一覧を表示
    SELECT * FROM sys.objects;

    -- ユーザー作成のテーブル一覧を表示
    SELECT * FROM sys.objects WHERE type = 'U';

    -- ビューの一覧を表示
    SELECT * FROM sys.objects WHERE type = 'V';

    -- テーブルの構造を表示
    SELECT  c.name ,n.name AS type ,c.max_length ,c.scale ,c.is_nullable
    FROM sys.objects t
    INNER JOIN sys.columns c ON t.object_id = c.object_id
    INNER JOIN sys.types n ON c.system_type_id = n.system_type_id
    WHERE t.name = 'test_table_1'
    ORDER BY c.column_id;

    -- セッションの一覧を表示
    SELECT conn.session_id, host_name, program_name, nt_domain, login_name, connect_time, last_request_end_time
    FROM sys.dm_exec_sessions sess
    JOIN sys.dm_exec_connections conn ON sess.session_id = conn.session_id;

    -- セッションの停止
    KILL {session_id};
    ```

    SQLサーバーの操作はコマンド実行よりもSQL Server Management Studio（SSMS）を使用するのが良い

## テーブル作成

各コンテナで使用するinit/init.sqlを参照

## インデックスによる動作速度の違い（MySQL）

1. DEの初期化

    ```bash
    { docker-compose down; docker-compose build; docker-compose up -d; }
    ```

1. performance_schemaにログが出力されるように設定を変更

    ```bash
    docker-compose exec mysql mysql -u root -pP@ssw0rd test_db -e "
        UPDATE performance_schema.setup_actors SET ENABLED = 'NO', HISTORY = 'NO' WHERE HOST = '%' AND USER = '%';
        INSERT INTO performance_schema.setup_actors (HOST,USER,ROLE,ENABLED,HISTORY) VALUES ('localhost','db_user','%','YES','YES');
        UPDATE performance_schema.setup_instruments SET ENABLED = 'YES', TIMED = 'YES' WHERE NAME LIKE '%statement/%';
        UPDATE performance_schema.setup_instruments SET ENABLED = 'YES', TIMED = 'YES' WHERE NAME LIKE '%stage/%';
        UPDATE performance_schema.setup_consumers SET ENABLED = 'YES' WHERE NAME LIKE '%events_statements_%';
        UPDATE performance_schema.setup_consumers SET ENABLED = 'YES' WHERE NAME LIKE '%events_stages_%';
    "
    ```

1. テストデータの投入

    ```bash
    # バッチでのデータの登録
    docker-compose exec python python db_test/manage.py insert_test_data
    ```

    ※テストデータの説明

    - テーブルのデータ量：1,000,000レコード
    - テーブルによる違い
        - index_test_table_no_index
            - インデックスを作成していないテーブル
        - index_test_table_single_int_index
            - 数値のカラムに対してそれぞれのカラムに単一インデックスを作成したテーブル
        - index_test_table_single_text_index
            - 文字列のカラムに対してそれぞれのカラムに単一インデックスを作成したテーブル
        - index_test_table_single_datetime_index
            - 時間のカラムに対してそれぞれのカラムに単一インデックスを作成したテーブル
        - index_test_table_multiple_int_index
            - 数値のカラムで複合インデックスを作成したテーブル
        - index_test_table_multiple_text_index
            - 文字列のカラムで複合インデックスを作成したテーブル
        - index_test_table_multiple_datetime_index
            - 時間のカラムで複合インデックスを作成したテーブル
        - index_test_table_multiple_index_1
            - 各型の1が付くカラムで複合インデックスを作成したテーブル
        - index_test_table_multiple_index_2
            - 各型の2が付くカラムで複合インデックスを作成したテーブル
        - index_test_table_multiple_index_3
            - 各型の3が付くカラムで複合インデックスを作成したテーブル
        - index_test_table_multiple_index_4
            - 各型の4が付くカラムで複合インデックスを作成したテーブル
    - カラムによる違い
        - int_1, varchar_1, datetime_1
            - カウントアップするような値で登録
        - int_2, varchar_2, datetime_2
            - 10種類の値をランダムに登録
        - int_3, varchar_3, datetime_3
            - 100種類の値をランダムに登録
        - int_4, varchar_4, datetime_4
            - 1,000,000種類の値をランダムに登録

1. 確認用のクエリを実行

    ```bash
    # 実行計画の取得
    docker-compose exec mysql bash -c "mysql -u db_user -pP@ssw0rd test_db -vvv < /tmp/sql/1_test_explain.sql > /tmp/sql/output_1_test_explain.txt"
    # SQL実行
    docker-compose exec mysql bash -c "mysql -u db_user -pP@ssw0rd test_db -vvv < /tmp/sql/2_test_select.sql > /tmp/sql/output_2_test_select.txt"
    # 実行時間の取得
    docker-compose exec mysql bash -c "mysql -u root -pP@ssw0rd test_db -vvv < /tmp/sql/3_select_statements_history.sql > /tmp/sql/output_3_select_statements_history.txt"
    ```
