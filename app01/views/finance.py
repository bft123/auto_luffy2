from django.shortcuts import render, redirect, HttpResponse
from app01 import models
from rbac.service.urls import memory_reverse
from app01.utils.bootstrap import BootStrapModelForm, BootStrapForm
from django import forms
import os
from datetime import datetime
import pandas as pd
from django.http import FileResponse
import mimetypes
from django.utils.encoding import escape_uri_path
from django.utils import timezone


# class UpModelForm(BootStrapModelForm):
#     # bootstrap_exclude_fields = ['img']
#
#     class Meta:
#         model = models.FinanceAccountUpload
#         fields = '__all__'

# def account_upload(req):
#     ''' 上传文件和数据(modelForm) '''
#     if req.method == 'GET':
#         # form = UpModelForm()
#         # return render(req, 'finance_account_list.html', {'form': form})
#         return render(req, 'finance_account_list.html')
#
#     # POST
#     form = UpModelForm(data=req.POST, files=req.FILES)
#     if form.is_valid():
#         # 对于文件：自动保存
#         # 字段 + 上传路径写入到数据库
#         form.save()
#         return HttpResponse('上传成功')
#     return render(req, 'upload_form.html', {'form': form})
#     return HttpResponse('account_upload')

# class FinanceAccountModelForm(BootStrapModelForm):
#     # bootstrap_exclude_fields = ['img']
#
#     class Meta:
#         model = models.FinanceAccount
#         fields = '__all__'
#         exclude = ['file']

class UpForm(BootStrapForm):
    bootstrap_exclude_fields = ['img']

    name = forms.CharField(label='姓名')
    age = forms.IntegerField(label='年龄')
    img = forms.FileField(label='头像')


def account_upload(req):
    if len(req.FILES) > 1 or len(req.FILES) == 0:
        return HttpResponse('只能上传一份文件')
    # fin_account fin_sku fin_data
    fin_account_obj = req.FILES.get('fin_account')
    fin_sku_obj = req.FILES.get('fin_sku')
    fin_data_obj = req.FILES.get('fin_data')
    if fin_account_obj:
        # 财务科目 只保留最新的一份，写入为csv
        saveFile('account', fin_account_obj)
        context = {'fin_account_msg': '上传成功'}
    if fin_sku_obj:
        # 财务sku 只保留最新的一份，写入为csv
        saveFile('sku', fin_sku_obj)
        context = {'fin_sku_msg': '上传成功'}
    if fin_data_obj:
        # 待检验数据 写入上传信息
        # 1.需要有财务科目 & 财务sku
        # 2.检验后生成是否匹配字段

        tz_now = timezone.now()
        now = datetime.now()
        # print(tz_now,now)
        # print(now)
        prefix_dt = datetime.strftime(now, '%Y%m%d%H%M%S')
        media_path = saveFile('data', fin_data_obj,prefix_dt)
        context = {'fin_data_msg': '上传成功'}
        # print(prefix_dt)
        models.FinanceAccount.objects.create(**{
            # 文件名加时datetime
            'filename': prefix_dt + '_' + fin_data_obj.name,
            'filepath': media_path,
            'is_alid': False,
            'upload_datetime': tz_now,
            'upload_person': req.session['info']['username'],
        })
    # query_set = models.FinanceAccount.objects.all()
    context['query_set'] = filterAccountData(req)
    return render(req, 'finance_account_list.html', context)


# 保存文件
def saveFile(path, file_obj, prefix_dt=''):
    if path in ['account', 'sku']:
        # 只保留最新文件
        del_file(os.path.join('media', path))
        media_path = os.path.join('media', path, file_obj.name)
    else:
        media_path = os.path.join('media', path, prefix_dt + '_' + file_obj.name)
    with open(media_path, mode='wb') as f:
        for chunk in file_obj.chunks():
            f.write(chunk)
    return media_path


# 删除文件夹下所有文件
def del_file(path, bugs=False):
    ls = os.listdir(path)
    for i in ls:
        c_path = os.path.join(path, i)
        if os.path.isdir(c_path):
            del_file(c_path)
        else:
            if not bugs:
                os.remove(c_path)
            else:
                if i.startswith('bugs_'):
                    os.remove(c_path)


def account_valid(req, pk):
    ''' 验证科目代码 '''
    # 0.验证前删除所有bugs开头的文件
    del_file(r'media\data', bugs=True)
    # 1.得到所有合法的财务科目代码
    # 2.得到所有的最新sku
    # 3.开始验证
    fin_model = models.FinanceAccount.objects.filter(id=pk)
    fin_model_one = fin_model.first()
    # 验证完了，有错直接下载；无错改状态字段
    error_rows, datas_out = toValid(fin_model_one.filepath)
    # error_rows=0
    print('error_rows : ', error_rows)
    if error_rows > 0:
        print('有错直接下载')
        # 有错直接下载
        filepath = r'media\data\bugs_{}'.format(fin_model_one.filename)
        datas_out.to_excel(filepath, index=False)
        # tpl_path = os.path.join(settings.BASE_DIR, 'web', 'files', '批量导入客户模板.xlsx')
        content_type = mimetypes.guess_type(filepath)[0]
        # print(content_type)
        response = FileResponse(open(filepath, mode='rb'), content_type=content_type)
        # print(type(fin_model_one.filename))
        response["Content-Type"] = "application/octet-stream"
        # response['Content-Disposition'] = "attachment;filename={}".format(fin_model_one.filename)
        response["Content-Disposition"] = "attachment;filename*=UTF-8''{}".format(
            escape_uri_path(fin_model_one.filename))
        return response
    else:
        print('验证成功返回页面')
        fin_model.update(**{'is_alid': True})
        return redirect('/finance/account/list/')


def account_del(req, pk):
    ''' 删除上传文件 '''
    faModels = models.FinanceAccount.objects.filter(id=pk)
    path = faModels.first().filepath
    if os.path.exists(path):  # 如果文件存在
        # 删除文件，可使用以下两种方法。
        os.remove(path)
    faModels.delete()
    return redirect('/finance/account/list/')


def toValid(filepath):
    ''' 验证文件 '''
    print('开始验证')
    # 读入财务科目明细
    all_account = pd.read_excel(r'media\account\财务科目明细.xlsx')

    # 读入SKU信息
    all_sku = pd.read_excel(r'media\sku\SKU信息.xlsx')

    # 修改相关字段
    datas = pd.read_excel(filepath, sheet_name=0, skiprows=4)
    datas.rename(columns={'Unnamed: 84': 'MKT统筹小计',
                          'Unnamed: 85': '渠道',
                          'Unnamed: 86': '费用归属',
                          'Unnamed: 87': '费用明细归属',
                          'Unnamed: 88': '备注',
                          'Unnamed: 89': '数据来源'},
                 inplace=True
                 )

    # 得到需要的源数据
    datas = datas[datas.columns[:90]]
    # 路过首行数据
    datas = datas.loc[1:, :]

    # 合并'财务科目','小计'为列表
    account_list = []
    for index, row in all_account[['财务科目', '小计']].iterrows():
        lt = []
        lt.append(row['财务科目'])
        lt.append(row['小计'])
        account_list.append(lt)

    all_account['财务科目2'] = account_list

    # groupby出所有的可能性，并删除重复值
    new_accounts = all_account.groupby(['渠道', '费用归属', '费用明细归属'])['财务科目2'].apply(sum).apply(set).apply(
        list).reset_index()

    # 得到所有需要判断的数值
    df = datas[datas.columns[13:84]]

    # 发现数据中有'、'，需要替换
    df = df.replace('、', '0')

    # 替换后把数据改成float64类型
    df['TP1.1销售折扣-总部规划（票折）'] = df['TP1.1销售折扣-总部规划（票折）'].astype('float64')

    # 如果数值>0，得到其表头并合并成列表
    account_list = []
    for index, row in df.iterrows():
        account_list.append(list(row.index[row > 0]))

    # 赋值给新列
    datas['表中科目代码'] = account_list

    # 左外关联 财务科目
    datas_out = pd.merge(datas, new_accounts, on=['渠道', '费用归属', '费用明细归属'], how='left')

    # 发现关联后的 财务科目可以 为值 nan
    datas_out['财务科目2'] = datas_out['财务科目2'].astype(str)
    datas_out['表中科目代码'] = datas_out['表中科目代码'].astype(str)

    # 得到符合结果，没匹配到的也不符合
    is_included_list = []
    for index, row in datas_out[['表中科目代码', '财务科目2']].iterrows():
        a = row['财务科目2']
        b = row['表中科目代码']
        if a == 'nan':
            is_included_list.append(0)
        else:
            is_included_list.append('1' if set(b) <= set(a) else '0')

    # 结果 赋值给新列
    datas_out['科目符合'] = is_included_list

    all_sku.rename(columns={
        '大类': '品类'
    }, inplace=True)

    datas_out2 = pd.merge(datas_out, all_sku, on=['产品代码', '产品名称', '品类', '明细类'], how='left')

    datas_out2['规格_y'] = datas_out2['规格_y'].astype(str)
    datas_out2['规格_y'] = datas_out2['规格_y'].apply(lambda x: '0' if x == 'nan' else '1')

    datas_out2.rename(columns={'规格_y': 'SKU符合'}, inplace=True)

    # 计算综合
    datas_out2['科目符合'] = datas_out2['科目符合'].astype(int)
    datas_out2['SKU符合'] = datas_out2['SKU符合'].astype(int)
    datas_out2['综合'] = datas_out2['科目符合'] + datas_out2['SKU符合']
    error_rows = len(datas_out2[datas_out2['综合'] < 2])
    # print(error_rows)
    # 导出数据
    # datas_out2.to_excel('tt2.xlsx', index=False)
    return error_rows, datas_out2


def account_list(req):
    if req.method == 'GET':
        # form = FinanceAccountModelForm()
        query_set = filterAccountData(req)
        return render(req, 'finance_account_list.html', {'query_set': query_set})

    # POST
    # form = FinanceAccountModelForm(data=req.POST, files=req.FILES)
    # if form.is_valid():
    #     # 对于文件：自动保存
    #     # 字段 + 上传路径写入到数据库
    #     form.save()
    #     return HttpResponse('上传成功')
    # return render(req, 'upload_form.html', {'form': form})
    # return HttpResponse('account_upload')


def filterAccountData(req):
    username = req.session['info']['username']
    if username not in ['bft', 'lyq']:
        query_set = models.FinanceAccount.objects.filter(upload_person=username)
    else:
        query_set = models.FinanceAccount.objects.all()
    return query_set
