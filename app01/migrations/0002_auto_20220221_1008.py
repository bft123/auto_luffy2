# Generated by Django 3.2.5 on 2022-02-21 02:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app01', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='FinanceAccount',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('filename', models.CharField(max_length=32, verbose_name='文件名')),
                ('filepath', models.CharField(max_length=32, verbose_name='文件路径')),
                ('is_alid', models.BooleanField(verbose_name='是否验证')),
                ('file', models.FileField(max_length=128, upload_to='fin/accountUpload/', verbose_name='账务科目')),
                ('upload_datetime', models.DateTimeField(verbose_name='上传时间')),
                ('upload_person', models.CharField(max_length=32, verbose_name='上传人')),
            ],
        ),
        migrations.AlterField(
            model_name='department',
            name='id',
            field=models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID'),
        ),
        migrations.AlterField(
            model_name='host',
            name='id',
            field=models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID'),
        ),
        migrations.AlterField(
            model_name='userinfo',
            name='id',
            field=models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID'),
        ),
    ]