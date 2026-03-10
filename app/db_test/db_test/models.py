from django.db import models


class IndexTestTable(models.Model):
    id = models.IntegerField(primary_key=True)
    int_1 = models.IntegerField(null=True)
    int_2 = models.IntegerField(null=True)
    int_3 = models.IntegerField(null=True)
    int_4 = models.IntegerField(null=True)
    varchar_1 = models.CharField(null=True, max_length=40)
    varchar_2 = models.CharField(null=True, max_length=40)
    varchar_3 = models.CharField(null=True, max_length=40)
    varchar_4 = models.CharField(null=True, max_length=40)
    datetime_1 = models.DateTimeField(null=True)
    datetime_2 = models.DateTimeField(null=True)
    datetime_3 = models.DateTimeField(null=True)
    datetime_4 = models.DateTimeField(null=True)

    class Meta:
        db_table = "index_test_table"
