from django.shortcuts import render, redirect, HttpResponse
from app01 import models
import os
from datetime import datetime
import pandas as pd
from django.http import FileResponse
import mimetypes
from django.utils.encoding import escape_uri_path
from django.utils import timezone
import warnings
warnings.filterwarnings("ignore")
import logging
import sys
import time

# 生成一个名为collect的logger实例
logger = logging.getLogger(__name__)


def act_list(req):
    logger.info("==========>" + sys._getframe().f_code.co_name)
    if req.method == 'GET':
        yearmonth = req.GET.get('yearmonth')
        if not yearmonth:
            yearmonth = time.strftime("%Y%m", time.localtime())
        query_set = filterAccountData(req)
        return render(req, 'salesmanagement_act_list.html', {'query_set': query_set, 'yearmonth': yearmonth})


def filterAccountData(req):
    logger.info("==========>" + sys._getframe().f_code.co_name)
    yearmonth = req.GET.get('yearmonth')
    if not yearmonth:
        yearmonth = time.strftime("%Y%m", time.localtime())
    # username = req.session['info']['username']
    # if username not in ['bft', 'jhzheng@hwccl']:
    username = req.session['info']['username']
    roles = req.session['info']['roles']
    if '管理员' not in roles and '销管ACT管理员' not in roles:
        query_set = models.SalesManagementACT.objects.filter(upload_person=username,yearmonth=yearmonth)
    else:
        query_set = models.SalesManagementACT.objects.filter(yearmonth=yearmonth)
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
    if path in ['sm_act/shops', 'sm_act/product']:
        # 只保留最新文件
        del_file(os.path.join('media', path))
        media_path = os.path.join('media', path, file_obj.name)
    else:
        media_path = os.path.join('media', path, file_obj.name)
    with open(media_path, mode='wb') as f:
        for chunk in file_obj.chunks():
            f.write(chunk)
    return media_path


def act_upload(req):
    logger.info("==========>" + sys._getframe().f_code.co_name)
    if len(req.FILES) > 1 or len(req.FILES) == 0:
        return HttpResponse('只能上传一份文件')
    # sm_act_shops sm_act_product sm_act_data
    sm_act_shops_obj = req.FILES.get('sm_act_shops')
    sm_act_product_obj = req.FILES.get('sm_act_product')
    sm_act_data_obj = req.FILES.get('sm_act_data')
    if sm_act_shops_obj:
        # 财务sku 只保留最新的一份，写入为csv
        saveFile('sm_act/shops', sm_act_shops_obj)
        context = {'sm_act_shops_msg': '上传成功'}
    if sm_act_product_obj:
        # 财务sku 只保留最新的一份，写入为csv
        saveFile('sm_act/product', sm_act_product_obj)
        context = {'sm_act_product_msg': '上传成功'}

    if sm_act_data_obj:
        yearmonth = req.POST.get('yearmonth')  # 接收参数
        # 待检验数据 写入上传信息
        # 1.需要有这些文件 sm_merchandise sm_shops sm_staff sm_product
        # 1.5 先写入数据库
        tz_now = timezone.now()
        now = datetime.now()
        prefix_dt = ''
        media_path = saveFile('sm_act/data',
                              sm_act_data_obj,
                              prefix_dt)
        context = {'sm_act_data_msg': '上传成功'}

        # 2.检验上传文件(无错不动，有错删除文件后，下载bugs文件)
        # 验证完了，有错直接下载；无错改状态字段
        try:
            error_rows, datas_out = toValid_act(media_path, yearmonth)
        except Exception as e:
            return HttpResponse(e)
        finally:
            # 删除上传的excel
            os.remove(media_path)

        # # 删除上传的excel
        # os.remove(media_path)
        cat = datas_out[3]
        allrows = error_rows[0] + error_rows[1]
        if allrows > 0:
            logger.info('有错直接下载')
            # 有错直接下载
            filepath = r'media/sm_act/bug/bugs_{}'.format(sm_act_data_obj.name)
            # 清空文件夹
            del_file(r'media/sm_act/bug/')
            # 2个sheet，需要修改
            if cat == '0':
                with pd.ExcelWriter(filepath) as writer:
                    # datas_out[0].to_excel(writer, sheet_name='档期异常', index=False)
                    datas_out[1].to_excel(writer, sheet_name='TP促销月度规划明细数据异常', index=False)
                    outname = 'TP促销月度规划明细数据异常'
            else:
                with pd.ExcelWriter(filepath) as writer:
                    datas_out[0].to_excel(writer, sheet_name='档期异常', index=False)
                    datas_out[1].to_excel(writer, sheet_name='LKA门店数与明细行数不匹配', index=False)
                    outname = '错误数据'
            content_type = mimetypes.guess_type(filepath)[0]
            response = FileResponse(open(filepath, mode='rb'), content_type=content_type)
            response["Content-Type"] = "application/octet-stream"
            response["Content-Disposition"] = "attachment;filename*=UTF-8''{}".format(
                escape_uri_path(outname+'.xlsx')
            )
            return response
        else:
            # 删除相关数据(一个账号一个年月只能上传一份数据)
            models.SalesManagementACT.objects.filter(yearmonth=yearmonth,
                                                     upload_person=req.session['info']['username']
                                                     ).delete()
            # 写入数据库
            input_filename = yearmonth + '_' + req.session['info']['username'] + '_玄讯导入表.xlsx'
            models.SalesManagementACT.objects.create(**{
                'filename': input_filename,
                'filepath': 'media/sm_act/data/' + input_filename,
                'yearmonth': yearmonth,
                # 'is_alid': False,
                'upload_datetime': now,
                'upload_person': req.session['info']['username'],
            })

            filepath = f'media/sm_act/data/{input_filename}'
            input_sheet = datas_out[2]
            input_sheet.drop(['陈列门店数', '门店信息_x', '门店信息', '产品信息_x', '档期是否异常'], axis=1, inplace=True)
            input_sheet.to_excel(filepath, index=False)

            content_type = mimetypes.guess_type(filepath)[0]
            response = FileResponse(open(filepath, mode='rb'), content_type=content_type)
            response["Content-Type"] = "application/octet-stream"
            response["Content-Disposition"] = "attachment;filename*=UTF-8''{}".format(
                escape_uri_path(input_filename)
            )
            return response

    context['query_set'] = filterAccountData(req)
    return render(req, 'salesmanagement_act_list.html', context)


def act_download(req):
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
    base = r'media/sm_act/combine'
    objs = models.SalesManagementACT.objects.filter(yearmonth=yearmonth)
    if len(objs) == 0:
        return HttpResponse(yearmonth + '无数据')
    filenames = [obj.filepath for obj in objs]
    df = []
    for filename in filenames:
        df.append(pd.read_excel(filename, index_col=None))
    df_combine = pd.concat(df)
    combine_filename = f'{yearmonth}_玄讯导入表合并.xlsx'
    combine_filepath = os.path.join(base, combine_filename)
    # 转成字符串
    df_combine['促销产品条码'] = df_combine['促销产品条码'].astype(str)
    df_combine.to_excel(combine_filepath, index=False)

    content_type = mimetypes.guess_type(combine_filepath)[0]
    response = FileResponse(open(combine_filepath, mode='rb'), content_type=content_type)
    response["Content-Type"] = "application/octet-stream"
    response["Content-Disposition"] = "attachment;filename*=UTF-8''{}".format(
        escape_uri_path(combine_filename)
    )
    return response


def act_download_model(req):
    logger.info("==========>" + sys._getframe().f_code.co_name)
    base = r'media/sm_act/model'
    combine_filename = 'TP促销月度规划明细_模板.xlsx'
    combine_filepath = os.path.join(base, combine_filename)
    return general_download(combine_filepath, combine_filename)


def general_download(filepath, filename):
    logger.info("==========>" + sys._getframe().f_code.co_name)
    content_type = mimetypes.guess_type(filepath)[0]
    response = FileResponse(open(filepath, mode='rb'), content_type=content_type)
    response["Content-Type"] = "application/octet-stream"
    response["Content-Disposition"] = "attachment;filename*=UTF-8''{}".format(
        escape_uri_path(filename)
    )
    return response


def act_del(req, pk):
    logger.info("==========>" + sys._getframe().f_code.co_name)
    ''' 删除上传文件 '''
    smModels = models.SalesManagementACT.objects.filter(id=pk)
    path = smModels.first().filepath
    filename = smModels.first().filename
    yearmonth = filename.split('_')[0]
    if os.path.exists(path):  # 如果文件存在
        # 删除文件，可使用以下两种方法。
        os.remove(path)
    smModels.delete()
    return redirect(f'/salesmanagement/act/list/?yearmonth={yearmonth}')

def act_download_one(req, pk):
    logger.info("==========>" + sys._getframe().f_code.co_name)
    ''' 删除上传文件 '''
    smModels = models.SalesManagementACT.objects.filter(id=pk)
    path = smModels.first().filepath
    filename = path.split('/')[-1]
    return general_download(path, filename)

def toValid_act(filepath, yearmonth):
    logger.info("==========>" + sys._getframe().f_code.co_name)
    logger.info(filepath)
    ''' 验证文件 '''
    # # TP促销月度规划明细
    # 读入TP促销月度规划明细
    try:
        tp_month_plan = pd.read_excel(filepath,
                                      keep_default_na=False,
                                      sheet_name="TP促销月度规划明细",
                                      skiprows=8,
                                      usecols=[
                                          "序列（序列不能调整）",
                                          "活动执行（是/否）每周确认，取消档期填否",
                                          "大区",
                                          "省份",
                                          "营业所",
                                          "渠道类型",
                                          "系统门店分级",
                                          "LKA系统名称",
                                          "月份",
                                          "门店数",
                                          "门店玄讯代码（非前系统10家以内提供，超10家门店添加明细附件）",
                                          "门店名称",
                                          "大类",
                                          "产品代码",
                                          "产品名称",
                                          "箱规",
                                          "促销类型",
                                          "规划单门店配额（件）",
                                          "规划门店总数量（件）",
                                          "规划门店总数量（瓶or袋）",
                                          "档期开始日期",
                                          "档期结束日期",
                                          "活动促销售价（含税瓶/袋）",
                                          "陈列门店数",
                                          "公司承担海报费",
                                          "明细类",
                                          "门店活动类型",
                                          "陈列规模"
                                      ]
                                      )
    except:
        df_tp_month_plan = pd.read_excel(r'media/sm_act/model/TP促销月度规划明细_模板.xlsx', sheet_name='TP促销月度规划明细', skiprows=8)
        err_msg = f'''
            读入 TP促销月度规划明细表 报错<br>
            表名 TP促销月度规划明细<br>
            表头所在行 第9行<br>
            表头 {df_tp_month_plan.columns.tolist()}
        '''
        raise Exception(err_msg)

    logger.info(tp_month_plan.columns)
    tp_month_plan.rename(columns={
        "序列（序列不能调整）": "序号",
        "活动执行（是/否）每周确认，取消档期填否": "活动执行",
        "门店玄讯代码（非前系统10家以内提供，超10家门店添加明细附件）": "门店玄讯代码",
    }, inplace=True)

    tp_month_plan.rename(columns={
        "规划单门店配额（件）": "规划单门店配额",
        "规划门店总数量（件）": "规划门店总数量",
        "活动促销售价（含税瓶/袋）": "活动促销售价",
    }, inplace=True)
    logger.info('TP促销月度规划明细读取完成')

    tp_month_plan['渠道类型_x'] = tp_month_plan['渠道类型'].apply(lambda x: '1' if x in ['LKA', 'MA'] else '0')
    tp_month_plan['系统门店分级_x'] = tp_month_plan['系统门店分级'].apply(
        lambda x: '1' if x in ['重点系统', '培育系统', '潜力系统', '便利系统', '重点门店', '培育门店', '潜力门店'] else '0')
    tp_month_plan['促销类型_x'] = tp_month_plan['促销类型'].apply(lambda x: '1' if x in ['大促', '店促'] else '0')
    tp_month_plan['档期开始日期_x'] = tp_month_plan['档期开始日期'].apply(
        lambda x: '1' if isinstance(x, datetime) else '0')
    tp_month_plan['档期结束日期_x'] = tp_month_plan['档期结束日期'].apply(
        lambda x: '1' if isinstance(x, datetime) else '0')
    tp_month_plan['活动执行_x'] = tp_month_plan['活动执行'].apply(lambda x: '1' if x in ['是', '否'] else '0')
    tp_month_plan['TP促销月度规划明细数据异常'] = tp_month_plan['渠道类型_x'] + tp_month_plan['系统门店分级_x'] + tp_month_plan['促销类型_x'] + \
                                      tp_month_plan['档期开始日期_x'] + tp_month_plan['档期结束日期_x'] + tp_month_plan['活动执行_x']
    tp_month_plan['TP促销月度规划明细数据异常'] = tp_month_plan['TP促销月度规划明细数据异常'].apply(lambda x: '1' if '0' not in x else '0')

    abnormal_act2 = []
    normal_act2 = tp_month_plan
    abnormal_data2 = tp_month_plan.query("TP促销月度规划明细数据异常=='0'")

    error_rows2 = len(abnormal_act2), len(abnormal_data2)
    input_file2 = abnormal_act2, abnormal_data2, normal_act2, '0'

    if len(abnormal_data2) > 0:
        return error_rows2, input_file2

    # # 促销门店明细
    # 读入促销门店明细
    try:
        tp_month_plan_children = pd.read_excel(filepath,
                                               keep_default_na=False,
                                               sheet_name="促销门店明细",
                                               )

        def add_index(group):
            group['序号'] = range(1, len(group) + 1)
            return group

        if len(tp_month_plan_children) == 0:
            tp_month_plan_children['序号'] = 0
        else:
            tp_month_plan_children = tp_month_plan_children.groupby(
                ["省区", "营业所", "系统名称", "系统门店分级", "月份", "产品代码", "档期开始日期", "档期结束日期"]).apply(
                add_index
            )

        tp_month_plan_children = tp_month_plan_children[
            ["序号", "省区", "营业所", "系统名称", "系统门店分级", "月份", "玄讯代码", "玄讯门店名称", "产品代码", "促销活动单品", "档期开始日期", "档期结束日期", "负责业务员",
             "促销类型",
             "是否陈列", "备注"]]
    except:
        df_tp_month_plan_children = pd.read_excel(r'media/sm_act/model/TP促销月度规划明细_模板.xlsx', sheet_name='促销门店明细')
        err_msg = f'''
                    读入 促销门店明细表 报错<br>
                    表名 促销门店明细表<br>
                    表头所在行 第1行<br>
                    表头 {df_tp_month_plan_children.columns.tolist()}
                '''
        raise Exception(err_msg)

    tp_month_plan_children['序号'] = tp_month_plan_children['序号'].apply(lambda x: str(x).zfill(4))
    logger.info('TP促销月度规划明细读取完成')

    # # 导入其它基表
    # 读入活动档期时间
    # act_timespan = pd.read_excel(r'活动档期时间.xlsx')

    # 读入产品信息
    sku_info = pd.read_excel(r'media/sm_act/product/产品信息.xlsx', dtype={'产品条形码': str})
    logger.info('产品信息读取完成')

    # 读入门店区域信息
    shop_info = pd.read_csv(r'media/sm_act/shops/门店区域信息.csv', dtype={'门店代码': str})
    shop_info['门店信息'] = shop_info['门店代码'] + ";" + shop_info['门店名称']
    # 防止后面门店匹配报错
    shop_info['省份'].fillna('全国', inplace=True)
    logger.info('门店区域信息读取完成')

    # # 玄讯导入表生成
    # yearmonth
    tp_month_plan['导入单号'] = tp_month_plan['省份'] + '-' + yearmonth + '-' + tp_month_plan['序号'].apply(
        lambda x: str(x).zfill(4))

    tp_month_plan['PN号'] = ''
    tp_month_plan['方案名称'] = tp_month_plan['明细类'] + '-' + tp_month_plan['门店活动类型']
    tp_month_plan['是否到店'] = '是'
    tp_month_plan['是否已拆门店'] = '是'
    tp_month_plan['变价开始日期'] = tp_month_plan['档期开始日期'].apply(lambda x: x.strftime('%Y-%m-%d'))
    tp_month_plan['变价结束日期'] = tp_month_plan['档期结束日期'].apply(lambda x: x.strftime('%Y-%m-%d'))
    tp_month_plan['翻牌开始日期'] = tp_month_plan['档期开始日期'].apply(lambda x: x.strftime('%Y-%m-%d'))
    tp_month_plan['翻牌结束日期'] = tp_month_plan['档期结束日期'].apply(lambda x: x.strftime('%Y-%m-%d'))
    tp_month_plan['费用类型'] = tp_month_plan['促销类型'] + '活动'
    tp_month_plan['促销目的'] = ''
    tp_month_plan['活动状态'] = tp_month_plan['活动执行']
    tp_month_plan['投放门店代码'] = tp_month_plan['门店玄讯代码']
    tp_month_plan['投放门店名称'] = tp_month_plan['门店名称']
    tp_month_plan['促销产品条码'] = ''
    tp_month_plan['促销产品名称'] = tp_month_plan['产品名称']
    tp_month_plan['促销产品单价（含税）'] = tp_month_plan['活动促销售价']
    tp_month_plan['产品配额'] = tp_month_plan['规划单门店配额']
    tp_month_plan['备注'] = tp_month_plan['门店活动类型'] + tp_month_plan['陈列规模']
    tp_month_plan['投放系统'] = ''

    input_sheet = tp_month_plan[
        ["渠道类型", "省份", "营业所", "LKA系统名称", "系统门店分级", "月份", "门店数", "档期开始日期", "档期结束日期", "导入单号", "PN号", "方案名称", "是否到店",
         "是否已拆门店",
         "变价开始日期", "变价结束日期", "翻牌开始日期", "翻牌结束日期", "费用类型", "促销目的", "活动状态", "投放系统", "投放门店代码", "投放门店名称", "促销产品条码", "产品代码",
         "促销产品名称", "促销产品单价（含税）", "产品配额", "备注", "陈列门店数"]]

    # 选择执行的活动
    input_sheet = input_sheet.query("活动状态=='是'")

    input_sheet = pd.merge(input_sheet, sku_info[['产品代码', '产品条形码']], on=['产品代码'], how='left')

    input_sheet.drop('促销产品条码', axis=1, inplace=True)

    input_sheet.rename(columns={'产品条形码': '促销产品条码'}, inplace=True)

    input_sheet = input_sheet[
        ["渠道类型", "省份", "营业所", "LKA系统名称", "系统门店分级", "月份", "门店数", "档期开始日期", "档期结束日期", "导入单号", "PN号", "方案名称", "是否到店",
         "是否已拆门店",
         "变价开始日期", "变价结束日期", "翻牌开始日期", "翻牌结束日期", "费用类型", "促销目的", "活动状态", "投放系统", "投放门店代码", "投放门店名称", "促销产品条码", "产品代码",
         "促销产品名称", "促销产品单价（含税）", "产品配额", "备注", "陈列门店数"]]

    MA = input_sheet.query("渠道类型 in ['MA','LKA'] and 门店数==1")

    MA['导入单号'] = MA['导入单号'].apply(lambda x: x + "-0000")

    LKA = input_sheet.query("渠道类型 == 'LKA' and 门店数!=1")

    # 无明细数据且主表门店数全为1
    if len(LKA) == 0:
        MA_LKA = MA
        abnorml_data = pd.DataFrame()
        MA_LKA2 = MA_LKA.drop(["省份", "LKA系统名称", "系统门店分级", "月份", "门店数", "档期开始日期", "档期结束日期"], axis=1)
        MA_LKA2.loc[:, '活动状态'] = '启用'
        MA_LKA2['投放门店代码'] = MA_LKA2['投放门店代码'].astype(str)

        # 根据 门店代码 门店名称 来判断 门店信息是否正确
        MA_LKA3 = pd.merge(MA_LKA2, shop_info[['门店代码', '门店名称', '省份']], left_on=['投放门店代码', '投放门店名称'],
                           right_on=['门店代码', '门店名称'], how='left')
        MA_LKA3 = pd.merge(MA_LKA3, shop_info[['门店代码', '门店信息']], left_on='投放门店代码', right_on='门店代码', how='left')
        MA_LKA3.loc[MA_LKA3['省份'].notnull(), '省份'] = '1'
        MA_LKA3.loc[MA_LKA3['省份'].isnull(), '省份'] = '0'

        MA_LKA3.drop(['产品代码', '营业所', '门店代码_x', '门店名称', '门店代码_y'], axis=1, inplace=True)
        MA_LKA3.rename(columns={'省份': '门店信息_x'}, inplace=True)
        # 去掉 方案名称 多余的-, 由于 门店活动类型 或者 陈列规模 有一个可能为空
        MA_LKA3['方案名称'] = MA_LKA3['方案名称'].apply(lambda s: s.rstrip('-'))
        # 根据 促销产品条码 来判断 产品信息是否正确
        MA_LKA3['产品信息_x'] = ''
        MA_LKA3.loc[MA_LKA3['促销产品条码'].notnull(), '产品信息_x'] = '1'
        MA_LKA3.loc[MA_LKA3['促销产品条码'].isnull(), '产品信息_x'] = '0'
        # 档期是否异常 如果 门店信息_x 或 产品信息_x 有1个异常 则异常
        MA_LKA3['档期是否异常'] = '1'
        MA_LKA3.loc[(MA_LKA3["门店信息_x"] == '0') | (MA_LKA3["产品信息_x"] == '0'), '档期是否异常'] = '0'
        abnormal_act = MA_LKA3.query("档期是否异常=='0'")
        normal_act = MA_LKA3.query("档期是否异常!='0'")

        logger.info(f'错误数据生成完成,档期异常{len(abnormal_act)}行,LKA门店数与明细行数不匹配{len(abnorml_data)}行')

        error_rows = len(abnormal_act), len(abnorml_data)
        input_file = abnormal_act, abnorml_data, normal_act, '1'

        return error_rows, input_file


    cnt = tp_month_plan_children.groupby(["省区", "营业所", "系统名称", "系统门店分级", "月份", "档期开始日期", "档期结束日期", "产品代码"])[
        ['序号']].count().reset_index()
    cnt.rename(columns={'序号': '行数'}, inplace=True)

    # 陈列门店数 校验
    cnt2 = tp_month_plan_children[tp_month_plan_children['是否陈列'] == '是'].groupby(
        ["省区", "营业所", "系统名称", "系统门店分级", "月份", "档期开始日期", "档期结束日期", "产品代码"])[['序号']].count().reset_index()
    cnt2.rename(columns={'序号': '明细陈列门店数'}, inplace=True)

    abnorml_data = pd.merge(LKA, cnt,
                            left_on=["省份", "营业所", "LKA系统名称", "系统门店分级", "月份", "档期开始日期", "档期结束日期", "产品代码"],
                            right_on=["省区", "营业所", "系统名称", "系统门店分级", "月份", "档期开始日期", "档期结束日期", "产品代码"],
                            how='left'
                            )

    # 陈列门店数 校验
    abnorml_data = pd.merge(abnorml_data, cnt2,
                            left_on=["省份", "营业所", "LKA系统名称", "系统门店分级", "月份", "档期开始日期", "档期结束日期", "产品代码"],
                            right_on=["省区", "营业所", "系统名称", "系统门店分级", "月份", "档期开始日期", "档期结束日期", "产品代码"],
                            how='left'
                            )
    # 陈列门店数 校验
    abnorml_data['明细陈列门店数'].fillna(0, inplace=True)
    abnorml_data['明细陈列门店数'] = abnorml_data['明细陈列门店数'].astype(int)
    abnorml_data['陈列门店数'] = abnorml_data['陈列门店数'].apply(lambda x: 0 if x == '' else x)
    abnorml_data['陈列门店数'] = abnorml_data['陈列门店数'].astype(int)

    # abnorml_data = abnorml_data.query("门店数!=行数")
    # 陈列门店数 校验
    abnorml_data = abnorml_data.query("门店数!=行数 or 陈列门店数!=明细陈列门店数")
    abnorml_data.drop(['省区_x', '系统名称_x', '省区_y', '系统名称_y'], axis=1, inplace=True)

    # 陈列门店数 校验, 检验数据放最后
    abnorml_data_x = abnorml_data[['门店数', '行数', '陈列门店数', '明细陈列门店数']]
    abnorml_data.drop(['门店数', '行数', '陈列门店数', '明细陈列门店数'], axis=1, inplace=True)
    abnorml_data = pd.concat([abnorml_data, abnorml_data_x], axis=1)
    abnorml_data.rename(columns={'行数': '明细门店数'}, inplace=True)

    # 根据LKA是否陈列添加备注筛选
    LKA2 = pd.merge(LKA,
                    tp_month_plan_children[
                        ["省区", "营业所", "系统名称", "系统门店分级", "月份", "档期开始日期", "档期结束日期", "产品代码", "序号", "玄讯代码", "玄讯门店名称","是否陈列"]],
                    left_on=["省份", "营业所", "LKA系统名称", "系统门店分级", "月份", "档期开始日期", "档期结束日期", "产品代码"],
                    right_on=["省区", "营业所", "系统名称", "系统门店分级", "月份", "档期开始日期", "档期结束日期", "产品代码"],
                    how='left')

    LKA2.drop(['投放门店代码', '投放门店名称'], axis=1, inplace=True)

    LKA2['导入单号'] = LKA2['导入单号'] + "-" + LKA2['序号']

    # 根据LKA是否陈列添加备注筛选
    LKA2.loc[LKA2['是否陈列'] != "是", "备注"] = ""

    LKA2 = LKA2[
        ["渠道类型", "省份", "营业所", "LKA系统名称", "系统门店分级", "月份", "门店数", "档期开始日期", "档期结束日期", "导入单号", "PN号", "方案名称", "是否到店",
         "是否已拆门店",
         "变价开始日期", "变价结束日期", "翻牌开始日期", "翻牌结束日期", "费用类型", "促销目的", "活动状态", "投放系统", "玄讯代码", "玄讯门店名称", "促销产品条码", "产品代码",
         "促销产品名称", "促销产品单价（含税）", "产品配额", "备注"]]

    LKA2.rename(columns={'玄讯代码': '投放门店代码', '玄讯门店名称': '投放门店名称'}, inplace=True)

    MA_LKA = pd.concat([MA, LKA2], axis=0)

    # 渠道类型 不删除
    MA_LKA2 = MA_LKA.drop(["省份", "LKA系统名称", "系统门店分级", "月份", "门店数", "档期开始日期", "档期结束日期"], axis=1)

    MA_LKA2.loc[:, '活动状态'] = '启用'

    # # 校验
    MA_LKA2['投放门店代码'] = MA_LKA2['投放门店代码'].astype(str)

    MA_LKA3 = pd.merge(MA_LKA2, shop_info[['门店代码', '门店名称', '省份']], left_on=['投放门店代码', '投放门店名称'],
                       right_on=['门店代码', '门店名称'],
                       how='left')
    MA_LKA3 = pd.merge(MA_LKA3, shop_info[['门店代码', '门店信息']], left_on='投放门店代码', right_on='门店代码', how='left')
    MA_LKA3.loc[MA_LKA3['省份'].notnull(), '省份'] = '1'
    MA_LKA3.loc[MA_LKA3['省份'].isnull(), '省份'] = '0'

    MA_LKA3.drop(['产品代码', '营业所', '门店代码_x', '门店名称', '门店代码_y'], axis=1, inplace=True)

    MA_LKA3.rename(columns={'省份': '门店信息_x'}, inplace=True)

    MA_LKA3['方案名称'] = MA_LKA3['方案名称'].apply(lambda s: s.rstrip('-'))

    MA_LKA3['产品信息_x'] = ''
    MA_LKA3.loc[MA_LKA3['促销产品条码'].notnull(), '产品信息_x'] = '1'
    MA_LKA3.loc[MA_LKA3['促销产品条码'].isnull(), '产品信息_x'] = '0'

    MA_LKA3['档期是否异常'] = '1'
    MA_LKA3.loc[(MA_LKA3["门店信息_x"] == '0') | (MA_LKA3["产品信息_x"] == '0'), '档期是否异常'] = '0'

    # 加主表的大类和营业所字段
    def get_pk(x):
        return int(x.split('-')[2])

    MA_LKA3['序号'] = MA_LKA3['导入单号'].apply(get_pk)
    MA_LKA3 = pd.merge(MA_LKA3, tp_month_plan[['序号', '营业所', '大类']], on=['序号'], how='left')
    MA_LKA3.drop('序号', axis=1, inplace=True)

    # MA_LKA3.to_excel('玄讯导入表2.xlsx', index=False)
    logger.info('玄讯导入表生成完成')

    abnormal_act = MA_LKA3.query("档期是否异常=='0'")
    normal_act = MA_LKA3.query("档期是否异常!='0'")

    # with pd.ExcelWriter('错误数据.xlsx') as writer:
    #     abnormal_act.to_excel(writer, sheet_name='档期异常', index=False)
    #     abnorml_data.to_excel(writer, sheet_name='LKA门店数与明细行数不匹配', index=False)

    logger.info(f'错误数据生成完成,档期异常{len(abnormal_act)}行,LKA门店数与明细行数不匹配{len(abnorml_data)}行')

    error_rows = len(abnormal_act), len(abnorml_data)
    input_file = abnormal_act, abnorml_data, normal_act, '1'

    # logger.info(error_rows)
    # 导出数据
    # datas_out2.to_excel('tt2.xlsx', index=False)
    return error_rows, input_file
