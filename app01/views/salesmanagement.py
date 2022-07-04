from django.shortcuts import render, redirect, HttpResponse
from app01 import models
import os
from datetime import datetime
import pandas as pd
from django.http import FileResponse
import mimetypes
from django.utils.encoding import escape_uri_path
from django.utils import timezone
import logging
import sys

# 生成一个名为collect的logger实例
logger = logging.getLogger(__name__)


def crc_list(req):
    logger.info("==========>" + sys._getframe().f_code.co_name)
    if req.method == 'GET':
        # form = FinanceAccountModelForm()
        query_set = filterAccountData(req)
        return render(req, 'salesmanagement_crc_list.html', {'query_set': query_set})


def filterAccountData(req):
    logger.info("==========>" + sys._getframe().f_code.co_name)
    username = req.session['info']['username']
    if username not in ['bft', 'yvonney@hwccl']:
        query_set = models.SalesManagementCRC.objects.filter(upload_person=username)
    else:
        query_set = models.SalesManagementCRC.objects.all()
    return query_set


# 删除文件夹下所有文件
def del_file(path, bugs=False):
    logger.info("==========>" + sys._getframe().f_code.co_name)
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


# 保存文件
def saveFile(path, file_obj, prefix_dt=''):
    logger.info("==========>" + sys._getframe().f_code.co_name)
    if path in ['sm/merchandise', 'sm/shops', 'sm/staff', 'sm/product']:
        # 只保留最新文件
        del_file(os.path.join('media', path))
        media_path = os.path.join('media', path, file_obj.name)
    else:
        media_path = os.path.join('media', path, file_obj.name)
    with open(media_path, mode='wb') as f:
        for chunk in file_obj.chunks():
            f.write(chunk)
    return media_path


def crc_upload(req):
    logger.info("==========>" + sys._getframe().f_code.co_name)
    if len(req.FILES) > 1 or len(req.FILES) == 0:
        return HttpResponse('只能上传一份文件')
    # sm_merchandise sm_shops sm_staff sm_product sm_crc_data
    sm_merchandise_obj = req.FILES.get('sm_merchandise')
    sm_shops_obj = req.FILES.get('sm_shops')
    sm_staff_obj = req.FILES.get('sm_staff')
    sm_product_obj = req.FILES.get('sm_product')
    sm_crc_data_obj = req.FILES.get('sm_crc_data')
    if sm_merchandise_obj:
        # 财务科目 只保留最新的一份，写入为csv
        saveFile('sm/merchandise', sm_merchandise_obj)
        context = {'sm_merchandise_msg': '上传成功'}
    if sm_shops_obj:
        # 财务sku 只保留最新的一份，写入为csv
        saveFile('sm/shops', sm_shops_obj)
        context = {'sm_shops_msg': '上传成功'}
    if sm_staff_obj:
        # 财务sku 只保留最新的一份，写入为csv
        saveFile('sm/staff', sm_staff_obj)
        context = {'sm_staff_msg': '上传成功'}
    if sm_product_obj:
        # 财务sku 只保留最新的一份，写入为csv
        saveFile('sm/product', sm_product_obj)
        context = {'sm_product_msg': '上传成功'}

    if sm_crc_data_obj:
        yearmonth = req.POST.get('yearmonth')  # 接收参数
        # 待检验数据 写入上传信息
        # 1.需要有这些文件 sm_merchandise sm_shops sm_staff sm_product
        # 1.5 先写入数据库
        tz_now = timezone.now()
        now = datetime.now()
        # prefix_dt = datetime.strftime(now, '%Y%m%d%H%M%S')
        prefix_dt = ''
        media_path = saveFile('sm/data',
                              sm_crc_data_obj,
                              prefix_dt)
        context = {'sm_crc_data_msg': '上传成功'}
        # 删除相关数据
        objects_filter = models.SalesManagementCRC.objects.filter(yearmonth=yearmonth,
                                                                  upload_person=req.session['info']['username'])
        if objects_filter:
            os.remove(objects_filter.first().filepath)

        objects_filter.delete()

        # 写入数据库
        sm_crc_data_file = models.SalesManagementCRC.objects.create(**{
            # 文件名加时datetime
            'filename': sm_crc_data_obj.name,
            # 'filename': yearmonth + '_' + req.session['info']['username']+'.xlsx',
            'filepath': media_path,
            'yearmonth': yearmonth,
            # 'is_alid': False,
            'upload_datetime': now,
            'upload_person': req.session['info']['username'],
        })
        # 2.检验上传文件(无错不动，有错删除文件后，下载bugs文件)
        error_rows = 0
        # 验证完了，有错直接下载；无错改状态字段
        error_rows, datas_out = toValid(sm_crc_data_file.filepath)
        if error_rows > 0:
            # 　删除上传文件及数据库数据
            os.remove(sm_crc_data_file.filepath)
            sm_crc_data_file.delete()

            logger.info('有错直接下载')
            # 有错直接下载
            filepath = r'media/sm/bug/bugs_{}'.format(sm_crc_data_file.filename)
            del_file(r'media/sm/bug/')
            datas_out.to_excel(filepath, index=False)
            # tpl_path = os.path.join(settings.BASE_DIR, 'web', 'files', '批量导入客户模板.xlsx')
            content_type = mimetypes.guess_type(filepath)[0]
            # print(content_type)
            response = FileResponse(open(filepath, mode='rb'), content_type=content_type)
            # print(type(fin_model_one.filename))
            response["Content-Type"] = "application/octet-stream"
            # response['Content-Disposition'] = "attachment;filename={}".format(fin_model_one.filename)
            response["Content-Disposition"] = "attachment;filename*=UTF-8''{}".format(
                escape_uri_path(sm_crc_data_obj.name)
                # escape_uri_path(filepath.split(r'\\')[-1])
            )
            return response
    context['query_set'] = filterAccountData(req)
    return render(req, 'salesmanagement_crc_list.html', context)


def crc_download(req):
    logger.info("==========>" + sys._getframe().f_code.co_name)
    '''
    202206_苏皖大区_XXXXX.xlsx
    :param req:
    :return:
    '''
    yearmonth = req.POST.get('yearmonth')  # 接收参数

    '''
        合并excel
        1.先从数据库根据 yearmonth 得到所有的 filename
        2.开始合并
    '''
    base = r'media/sm/combine'
    objs = models.SalesManagementCRC.objects.filter(yearmonth=yearmonth)
    if len(objs) == 0:
        return HttpResponse(yearmonth+'无数据')
    filenames = [obj.filepath for obj in objs]
    df = []
    for filename in filenames:
        df.append(pd.read_excel(filename, index_col=None))
    df_combine = pd.concat(df)
    combine_filename = f'{yearmonth}_合并.xlsx'
    combine_filepath = os.path.join(base, combine_filename)
    df_combine.to_excel(combine_filepath, index=False)

    # filepath = r'media\sm\data\20220624141157_待导入文件_正确.xlsx'
    content_type = mimetypes.guess_type(combine_filepath)[0]
    # print(content_type)
    response = FileResponse(open(combine_filepath, mode='rb'), content_type=content_type)
    # print(type(fin_model_one.filename))
    response["Content-Type"] = "application/octet-stream"
    # response['Content-Disposition'] = "attachment;filename={}".format(fin_model_one.filename)
    response["Content-Disposition"] = "attachment;filename*=UTF-8''{}".format(
        escape_uri_path(combine_filename)
        # escape_uri_path(filepath.split(r'\\')[-1])
    )
    return response

def crc_download_model(req):
    logger.info("==========>" + sys._getframe().f_code.co_name)
    base = r'media/sm/model'
    combine_filename = 'CRC导入模板.xlsx'
    combine_filepath = os.path.join(base, combine_filename)

    content_type = mimetypes.guess_type(combine_filepath)[0]
    response = FileResponse(open(combine_filepath, mode='rb'), content_type=content_type)
    response["Content-Type"] = "application/octet-stream"
    response["Content-Disposition"] = "attachment;filename*=UTF-8''{}".format(
        escape_uri_path(combine_filename)
    )
    return response

def crc_del(req, pk):
    logger.info("==========>" + sys._getframe().f_code.co_name)
    ''' 删除上传文件 '''
    smModels = models.SalesManagementCRC.objects.filter(id=pk)
    path = smModels.first().filepath
    if os.path.exists(path):  # 如果文件存在
        # 删除文件，可使用以下两种方法。
        os.remove(path)
    smModels.delete()
    return redirect('/salesmanagement/crc/list/')


def toValid(filepath):
    logger.info("==========>" + sys._getframe().f_code.co_name)
    logger.info(filepath)
    ''' 验证文件 '''
    # 读入经销商信息
    # r'media\account\财务科目明细.xlsx'
    merchandise_info = pd.read_excel(r'media/sm/merchandise/经销商信息.xlsx', keep_default_na=False)
    merchandise_info['省区'] = merchandise_info['省区'].map(lambda x: x.replace('省', ''))
    merchandise_info = merchandise_info[["大区", "省区", "营业所", "供货经销商代码", "供货经销商名称"]]
    merchandise_info['经销商信息'] = merchandise_info.apply(lambda x: ';'.join(x), axis=1)
    logger.info('读入经销商信息')

    # 读入门店信息
    shops_info = pd.read_csv(r'media/sm/shops/门店信息.csv', keep_default_na=False)
    shops_info = shops_info[["终端编码", "终端名称", "状态", "终端类型", "终端级别", "省", "市", "区", "镇", "详细地址"]]
    shops_info.rename(columns={
        '终端级别': '通路名称',
        '终端类型': '客户分类',
        '终端编码': '门店编号',
        '终端名称': '门店名称',
        '镇': '乡镇',
        '详细地址': '路及门牌',
    }, inplace=True)
    shops_info = shops_info[["通路名称", "客户分类", "门店编号", "门店名称", "省", "市", "区", "乡镇", "路及门牌", "状态"]]
    shops_info['门店信息'] = shops_info.apply(lambda x: ';'.join(x), axis=1)
    logger.info('读入门店信息')

    # 读入人员信息
    staff_info = pd.read_excel(r'media/sm/staff/人员信息.xlsx', keep_default_na=False)
    staff_info = staff_info[["工号", "业务姓名", "人员属性"]]
    staff_info['人员信息'] = staff_info.apply(lambda x: ';'.join(x), axis=1)
    logger.info('读入人员信息')

    # 读入产品信息
    product_info = pd.read_excel(r'media/sm/product/产品信息.xlsx', keep_default_na=False, dtype={'箱入数': str})
    product_info = product_info[['产品代码', '产品名称', '箱入数']]
    product_info['产品信息'] = product_info.apply(lambda x: ';'.join(x), axis=1)
    logger.info('读入产品信息')

    # 读入待导入文件
    input_file = pd.read_excel(filepath, keep_default_na=False, dtype={'箱入数': str, '拜访日期': str})

    input_file.rename(columns={
        '工号\n（直接人力填）': '工号',
        '人员属性\n（有下拉）': '人员属性',
    }, inplace=True)
    logger.info('读入待导入文件')

    # # 校验经销商信息
    input_file_merchandise = pd.merge(input_file, merchandise_info,
                                      on=["大区", "省区", "营业所", "供货经销商代码", "供货经销商名称"],
                                      how='left',
                                      )
    input_file_merchandise = pd.merge(input_file_merchandise, merchandise_info[['供货经销商代码', '经销商信息']],
                                      on=["供货经销商代码"],
                                      how='left',
                                      )
    input_file_merchandise.loc[input_file_merchandise['经销商信息_x'].notnull(), '经销商信息_x'] = '1'
    input_file_merchandise.loc[input_file_merchandise['经销商信息_x'].isnull(), '经销商信息_x'] = '0'

    # 查看问题经销商信息
    # input_file_merchandise[input_file_merchandise['经销商信息_x'] == '0']
    logger.info(f"校验经销商信息,不符合的有{len(input_file_merchandise[input_file_merchandise['经销商信息_x'] == '0'])}条")

    # # 校验门店信息
    shops_info['门店编号'] = shops_info['门店编号'].astype(str)
    input_file_merchandise['门店编号'] = input_file_merchandise['门店编号'].astype(str)
    input_file_shops = pd.merge(input_file_merchandise, shops_info,
                                on=["通路名称", "客户分类", "门店编号", "门店名称", "省", "市", "区", "乡镇", "路及门牌", "状态"],
                                how='left',
                                )
    input_file_shops = pd.merge(input_file_shops, shops_info[['门店编号', '门店信息']],
                                on=["门店编号"],
                                how='left',
                                )
    input_file_shops.loc[input_file_shops['门店信息_x'].notnull(), '门店信息_x'] = '1'
    input_file_shops.loc[input_file_shops['门店信息_x'].isnull(), '门店信息_x'] = '0'

    # 查看问题门店信息
    # input_file_shops[input_file_shops['门店信息_x'] == '0']
    logger.info(f"校验门店信息,不符合的有{len(input_file_shops[input_file_shops['门店信息_x'] == '0'])}条")

    # # 校验人员信息
    input_file_staff = pd.merge(input_file_shops, staff_info,
                                on=["工号", "业务姓名", "人员属性"],
                                how='left',
                                )
    input_file_staff.loc[input_file_staff['人员信息'].notnull(), '人员信息'] = '1'
    input_file_staff.loc[input_file_staff['人员信息'].isnull(), '人员信息'] = '0'

    # 查看问题人员信息
    # input_file_staff[input_file_staff['人员信息'] == '0']
    logger.info(f"校验人员信息,不符合的有{len(input_file_staff[input_file_staff['人员信息'] == '0'])}条")

    # # 校验产品信息
    input_file_product = pd.merge(input_file_staff, product_info,
                                  on=['产品代码', '产品名称', '箱入数'],
                                  how='left',
                                  )
    input_file_product = pd.merge(input_file_product, product_info[['产品代码', '产品信息']],
                                  on=["产品代码"],
                                  how='left',
                                  )
    input_file_product.loc[input_file_product['产品信息_x'].notnull(), '产品信息_x'] = '1'
    input_file_product.loc[input_file_product['产品信息_x'].isnull(), '产品信息_x'] = '0'

    # 查看问题产品信息
    # input_file_product.query('产品信息_x=="0"')
    lenX = len(input_file_product.query('产品信息_x=="0"'))
    logger.info(f"校验产品信息,不符合的有{lenX}条")

    # # 校验其它信息
    # 售价瓶 0<x<200
    def sjp(x):
        ret = '1'
        try:
            if x >= 200 or x <= 0:
                ret = '0'
        except:
            ret = '0'
        return ret

    input_file_product['售价瓶_x'] = input_file_product['售价瓶'].apply(sjp)

    # 查看问题售价瓶信息
    # input_file_product.query('售价瓶_x=="0"')
    lenY = len(input_file_product.query('售价瓶_x=="0"'))
    logger.info(f"校验售价瓶,不符合的有{lenY}条")

    def pfrq(x):
        ret = '1'
        try:
            datetime.strptime(x.replace(' 00:00:00', ''), "%Y-%m-%d")
        except:
            ret = '0'
        return ret

    # 拜访日期 yyyy/M/dd
    input_file_product['拜访日期_x'] = input_file_product['拜访日期'].apply(pfrq)

    # 查看问题拜访日期
    # input_file_product.query('拜访日期_x=="0"')
    lenZ = len(input_file_product.query('拜访日期_x=="0"'))
    logger.info(f"校验拜访日期,不符合的有{lenZ}条")

    # # 综合校验
    def combine(x):
        ret = '1'
        if '0' in ",".join(x):
            ret = '0'
        return ret

    input_file_product['校验结果'] = input_file_product[['经销商信息_x', '门店信息_x', '人员信息', '产品信息_x', '售价瓶_x', '拜访日期_x']].apply(
        combine, axis=1)

    # 查看问题综合
    # input_file_product.query("校验结果=='0'")
    lenA = len(input_file_product.query("校验结果=='0'"))
    logger.info(f"综上所述,不符合的有{lenA}条")

    error_rows = lenA
    # 导出数据
    # datas_out2.to_excel('tt2.xlsx', index=False)
    return error_rows, input_file_product
