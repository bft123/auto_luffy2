# Generated by Django 3.2.12 on 2022-06-24 02:55

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app01', '0003_remove_financeaccount_file'),
    ]

    operations = [
        migrations.CreateModel(
            name='SalesManagementCRC',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('filename', models.CharField(max_length=32, verbose_name='文件名')),
                ('filepath', models.CharField(max_length=32, verbose_name='文件路径')),
                ('upload_datetime', models.DateTimeField(verbose_name='上传时间')),
                ('upload_person', models.CharField(max_length=32, verbose_name='上传人')),
            ],
        ),
    ]
