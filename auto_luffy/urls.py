"""auto_luffy URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url, include
from django.contrib import admin
from app01.views import user
from app01.views import host
from app01.views import account
from app01.views import finance
from app01.views import salesmanagement
from app01.views import salesmanagementAct
# 启用media 1
from django.urls import path, re_path
from django.views.static import serve
from django.conf import settings

urlpatterns = [
    # 启用media 2
    re_path(r'^media/(?P<path>.*)$', serve, {'document_root': settings.MEDIA_ROOT}, name='media'),

    url(r'^admin/', admin.site.urls),

    url(r'^login/$', account.login, name='login'),
    url(r'^logout/$', account.logout, name='logout'),

    url(r'^index/$', account.index, name='index'),

    # 大屏
    # url(r'^bigscreen/test/list/$', finance.account_list, name='finance_account_list'),

    # 财务
    url(r'^finance/account/list/$', finance.account_list, name='finance_account_list'),
    url(r'^finance/account/upload/$', finance.account_upload, name='finance_account_upload'),
    url(r'^finance/account/del/(?P<pk>\d+)/$', finance.account_del, name='finance_account_del'),
    url(r'^finance/account/valid/(?P<pk>\d+)/$', finance.account_valid, name='finance_account_valid'),

    # 销管CRC
    url(r'^salesmanagement/crc/list/$', salesmanagement.crc_list, name='salesmanagement_crc_list'),
    url(r'^salesmanagement/crc/upload/$', salesmanagement.crc_upload, name='salesmanagement_crc_upload'),
    url(r'^salesmanagement/crc/download/$', salesmanagement.crc_download, name='salesmanagement_crc_download'),
    url(r'^salesmanagement/crc/download_model/$', salesmanagement.crc_download_model, name='salesmanagement_crc_download_model'),
    url(r'^salesmanagement/crc/del/(?P<pk>\d+)/$', salesmanagement.crc_del, name='salesmanagement_crc_del'),
    # url(r'^finance/account/valid/(?P<pk>\d+)/$', finance.account_valid, name='finance_account_valid'),

    # 销管档期
    url(r'^salesmanagement/act/list/$', salesmanagementAct.act_list, name='salesmanagement_act_list'),
    url(r'^salesmanagement/act/upload/$', salesmanagementAct.act_upload, name='salesmanagement_act_upload'),
    url(r'^salesmanagement/act/download/$', salesmanagementAct.act_download, name='salesmanagement_act_download'),
    url(r'^salesmanagement/act/download_model/$', salesmanagementAct.act_download_model, name='salesmanagement_act_download_model'),
    url(r'^salesmanagement/act/del/(?P<pk>\d+)/$', salesmanagementAct.act_del, name='salesmanagement_act_del'),

    # 用户
    url(r'^user/list/$', user.user_list, name='user_list'),
    url(r'^user/add/$', user.user_add, name='user_add'),
    url(r'^user/edit/(?P<pk>\d+)/$', user.user_edit, name='user_edit'),
    url(r'^user/del/(?P<pk>\d+)/$', user.user_del, name='user_del'),
    url(r'^user/reset/password/(?P<pk>\d+)/$', user.user_reset_pwd, name='user_reset_pwd'),

    # 主机
    url(r'^host/list/$', host.host_list, name='host_list'),
    url(r'^host/add/$', host.host_add, name='host_add'),
    url(r'^host/edit/(?P<pk>\d+)/$', host.host_edit, name='host_edit'),
    url(r'^host/del/(?P<pk>\d+)/$', host.host_del, name='host_del'),

    url(r'^rbac/', include(('rbac.urls', 'rbac'), namespace='rbac')),

]
