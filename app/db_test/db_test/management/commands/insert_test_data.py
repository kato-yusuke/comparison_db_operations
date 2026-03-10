from django.core.management.base import BaseCommand
from db_test.models import IndexTestTable
from datetime import datetime, timedelta
from random import randint
from django.utils.timezone import make_aware
from django.db import connection


class Command(BaseCommand):

    def handle(self, *args, **options):
        # バッチ開始時間を記録
        start_time = datetime.now()
        print(f"{start_time} : batch start")

        datas = []
        for i in range(1000000):
            int_1 = i
            int_2 = randint(1, 10)
            int_3 = randint(1, 100)
            int_4 = randint(1, 1000000)
            varchar_1 = f"test_{i:010d}"
            varchar_2 = f"test_{randint(1, 10):010d}"
            varchar_3 = f"test_{randint(1, 100):010d}"
            varchar_4 = f"test_{randint(1, 1000000):010d}"
            datetime_1 = make_aware(
                datetime(
                    year=2000,
                    month=1,
                    day=1,
                    hour=0,
                    minute=0,
                    second=0,
                )
                + timedelta(days=int_1)
            )
            datetime_2 = make_aware(
                datetime(
                    year=2000,
                    month=1,
                    day=1,
                    hour=0,
                    minute=0,
                    second=0,
                )
                + timedelta(days=randint(1, 10))
            )
            datetime_3 = make_aware(
                datetime(
                    year=2000,
                    month=1,
                    day=1,
                    hour=0,
                    minute=0,
                    second=0,
                )
                + timedelta(days=randint(1, 100))
            )
            datetime_4 = make_aware(
                datetime(
                    year=2000,
                    month=1,
                    day=1,
                    hour=0,
                    minute=0,
                    second=0,
                )
                + timedelta(days=randint(1, 1000000))
            )

            datas.append(
                IndexTestTable(
                    int_1=int_1,
                    int_2=int_2,
                    int_3=int_3,
                    int_4=int_4,
                    varchar_1=varchar_1,
                    varchar_2=varchar_2,
                    varchar_3=varchar_3,
                    varchar_4=varchar_4,
                    datetime_1=datetime_1,
                    datetime_2=datetime_2,
                    datetime_3=datetime_3,
                    datetime_4=datetime_4,
                )
            )

            if len(datas) >= 100000:
                # 一定数のデータが溜まったらindex_test_tableに登録
                IndexTestTable.objects.bulk_create(datas)
                print(f"{datetime.now()} : insert index_test_table row {i + 1}")
                datas = []
        if len(datas) > 0:
            # 残ったデータをindex_test_tableに登録
            IndexTestTable.objects.bulk_create(datas)
        # index_test_tableへの登録終了時間を記録
        insert_end_index_test_table_time = datetime.now()
        print(f"{insert_end_index_test_table_time} : insert end index_test_table")

        # DBコネクションの取得
        with connection.cursor() as cursor:
            # index_test_table_no_indexにデータを移す
            cursor.execute(
                "INSERT IGNORE INTO index_test_table_no_index SELECT * FROM index_test_table"
            )
            # index_test_table_no_indexへの登録終了時間を記録
            insert_end_index_test_table_no_index_time = datetime.now()
            print(
                f"{insert_end_index_test_table_no_index_time} : insert end index_test_table_no_index"
            )

            # index_test_table_single_int_indexにデータを移す
            cursor.execute(
                "INSERT IGNORE INTO index_test_table_single_int_index SELECT * FROM index_test_table"
            )
            # index_test_table_single_int_indexへの登録終了時間を記録
            insert_end_index_test_table_single_int_index_time = datetime.now()
            print(
                f"{insert_end_index_test_table_single_int_index_time} : insert end index_test_table_single_int_index"
            )

            # index_test_table_single_text_indexにデータを移す
            cursor.execute(
                "INSERT IGNORE INTO index_test_table_single_text_index SELECT * FROM index_test_table"
            )
            # index_test_table_single_text_indexへの登録終了時間を記録
            insert_end_index_test_table_single_text_index_time = datetime.now()
            print(
                f"{insert_end_index_test_table_single_text_index_time} : insert end index_test_table_single_text_index"
            )

            # index_test_table_single_datetime_indexにデータを移す
            cursor.execute(
                "INSERT IGNORE INTO index_test_table_single_datetime_index SELECT * FROM index_test_table"
            )
            # index_test_table_single_datetime_indexへの登録終了時間を記録
            insert_end_index_test_table_single_datetime_index_time = datetime.now()
            print(
                f"{insert_end_index_test_table_single_datetime_index_time} : insert end index_test_table_single_datetime_index"
            )

            # index_test_table_multiple_int_indexにデータを移す
            cursor.execute(
                "INSERT IGNORE INTO index_test_table_multiple_int_index SELECT * FROM index_test_table"
            )
            # index_test_table_multiple_int_indexへの登録終了時間を記録
            insert_end_index_test_table_multiple_int_index_time = datetime.now()
            print(
                f"{insert_end_index_test_table_multiple_int_index_time} : insert end index_test_table_multiple_int_index"
            )

            # index_test_table_multiple_text_indexにデータを移す
            cursor.execute(
                "INSERT IGNORE INTO index_test_table_multiple_text_index SELECT * FROM index_test_table"
            )
            # index_test_table_multiple_text_indexへの登録終了時間を記録
            insert_end_index_test_table_multiple_text_index_time = datetime.now()
            print(
                f"{insert_end_index_test_table_multiple_text_index_time} : insert end index_test_table_multiple_text_index"
            )

            # index_test_table_multiple_datetime_indexにデータを移す
            cursor.execute(
                "INSERT IGNORE INTO index_test_table_multiple_datetime_index SELECT * FROM index_test_table"
            )
            # index_test_table_multiple_datetime_indexへの登録終了時間を記録
            insert_end_index_test_table_multiple_datetime_index_time = datetime.now()
            print(
                f"{insert_end_index_test_table_multiple_datetime_index_time} : insert end index_test_table_multiple_datetime_index"
            )

            # index_test_table_multiple_index_1にデータを移す
            cursor.execute(
                "INSERT IGNORE INTO index_test_table_multiple_index_1 SELECT * FROM index_test_table"
            )
            # index_test_table_multiple_index_1への登録終了時間を記録
            insert_end_index_test_table_multiple_index_1_time = datetime.now()
            print(
                f"{insert_end_index_test_table_multiple_index_1_time} : insert end index_test_table_multiple_index_1"
            )

            # index_test_table_multiple_index_2にデータを移す
            cursor.execute(
                "INSERT IGNORE INTO index_test_table_multiple_index_2 SELECT * FROM index_test_table"
            )
            # index_test_table_multiple_index_2への登録終了時間を記録
            insert_end_index_test_table_multiple_index_2_time = datetime.now()
            print(
                f"{insert_end_index_test_table_multiple_index_2_time} : insert end index_test_table_multiple_index_2"
            )

            # index_test_table_multiple_index_3にデータを移す
            cursor.execute(
                "INSERT IGNORE INTO index_test_table_multiple_index_3 SELECT * FROM index_test_table"
            )
            # index_test_table_multiple_index_3への登録終了時間を記録
            insert_end_index_test_table_multiple_index_3_time = datetime.now()
            print(
                f"{insert_end_index_test_table_multiple_index_3_time} : insert end index_test_table_multiple_index_3"
            )

            # index_test_table_multiple_index_4にデータを移す
            cursor.execute(
                "INSERT IGNORE INTO index_test_table_multiple_index_4 SELECT * FROM index_test_table"
            )
            # index_test_table_multiple_index_4への登録終了時間を記録
            insert_end_index_test_table_multiple_index_4_time = datetime.now()
            print(
                f"{insert_end_index_test_table_multiple_index_4_time} : insert end index_test_table_multiple_index_4"
            )

        # バッチ終了時間を記録
        end_time = datetime.now()
        print(f"{end_time} : batch end")

        print("")

        # 各処理の実行時間を表示
        print(
            f"insert end index_test_table seconds                         : {(
                insert_end_index_test_table_time 
                - start_time).total_seconds()
                }"
        )
        print(
            f"insert end index_test_table_no_index seconds                : {(
                insert_end_index_test_table_no_index_time 
                - insert_end_index_test_table_time).total_seconds()
                }"
        )
        print(
            f"insert end index_test_table_single_int_index seconds        : {(
                insert_end_index_test_table_single_int_index_time
                - insert_end_index_test_table_no_index_time).total_seconds()
                }"
        )
        print(
            f"insert end index_test_table_single_text_index seconds       : {(
                insert_end_index_test_table_single_text_index_time
                - insert_end_index_test_table_single_int_index_time).total_seconds()
                }"
        )
        print(
            f"insert end index_test_table_single_datetime_index seconds   : {(
                insert_end_index_test_table_single_datetime_index_time
                - insert_end_index_test_table_single_text_index_time).total_seconds()
                }"
        )
        print(
            f"insert end index_test_table_multiple_int_index seconds      : {(
                insert_end_index_test_table_multiple_int_index_time
                - insert_end_index_test_table_single_datetime_index_time).total_seconds()
                }"
        )
        print(
            f"insert end index_test_table_multiple_text_index seconds     : {(
                insert_end_index_test_table_multiple_text_index_time
                - insert_end_index_test_table_multiple_int_index_time).total_seconds()
                }"
        )
        print(
            f"insert end index_test_table_multiple_datetime_index seconds : {(
                insert_end_index_test_table_multiple_datetime_index_time
                - insert_end_index_test_table_multiple_text_index_time).total_seconds()
                }"
        )
        print(
            f"insert end index_test_table_multiple_index_1 seconds        : {(
                insert_end_index_test_table_multiple_index_1_time
                - insert_end_index_test_table_multiple_datetime_index_time).total_seconds()
                }"
        )
        print(
            f"insert end index_test_table_multiple_index_2 seconds        : {(
                insert_end_index_test_table_multiple_index_2_time
                - insert_end_index_test_table_multiple_index_1_time).total_seconds()
                }"
        )
        print(
            f"insert end index_test_table_multiple_index_3 seconds        : {(
                insert_end_index_test_table_multiple_index_3_time
                - insert_end_index_test_table_multiple_index_2_time).total_seconds()
                }"
        )
        print(
            f"insert end index_test_table_multiple_index_4 seconds        : {(
                insert_end_index_test_table_multiple_index_4_time
                - insert_end_index_test_table_multiple_index_3_time).total_seconds()
                }"
        )
