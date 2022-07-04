import os

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/1.11/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used cdin production secret!
SECRET_KEY = '*y19rfiwf&d+s)pkclz^z8ty&ss3o77a53%6=%d&1ln%$7yz27'

# SECURITY WARNING: don't run with debug turned on in production!
# for online
DEBUG = False

ALLOWED_HOSTS = ['*']

# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'app01.apps.App01Config',
    'rbac.apps.RbacConfig'
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'rbac.middlewares.rbac.RbacMiddleware',
]

ROOT_URLCONF = 'auto_luffy.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')]
        ,
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'auto_luffy.wsgi.application'

# Database
# https://docs.djangoproject.com/en/1.11/ref/settings/#databases

# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.sqlite3',
#         'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
#     }
# }

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': "django_web",
        'USER': 'root',
        'PASSWORD': 'root',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}

# Password validation
# https://docs.djangoproject.com/en/1.11/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

# Internationalization
# https://docs.djangoproject.com/en/1.11/topics/i18n/

# LANGUAGE_CODE = 'en-us'
LANGUAGE_CODE = 'zh-hans'

# TIME_ZONE = 'UTC'
TIME_ZONE = 'Asia/Shanghai'

USE_I18N = True

USE_L10N = True

USE_TZ = False

# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.11/howto/static-files/

STATIC_URL = '/static/'
# for online
STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'rbac/static')
]
STATIC_ROOT = os.path.join(BASE_DIR, 'static')

# #################### 权限相关配置 #######################
# 业务中的用户表
RBAC_USER_MODLE_CLASS = "app01.models.UserInfo"
# 权限在Session中存储的key
PERMISSION_SESSION_KEY = "luffy_permission_url_list_key"
# 菜单在Session中存储的key
MENU_SESSION_KEY = "luffy_permission_menu_key"

# 白名单
VALID_URL_LIST = [
    '/login/',
    '/admin/.*'
]

# 需要登录但无需权限的URL
NO_PERMISSION_LIST = [
    '/index/',
    '/logout/',
]

# 自动化发现路由中URL时，排除的URL
AUTO_DISCOVER_EXCLUDE = [
    '/admin/.*',
    '/login/',
    '/logout/',
    '/index/',
]

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

# 启用media 3
import os

MEDIA_ROOT = os.path.join(BASE_DIR, "media")
MEDIA_URL = "/media/"

# 添加日志
BASE_LOG_DIR = os.path.join(BASE_DIR, "log")
if not os.path.exists(BASE_LOG_DIR):
    os.mkdir(BASE_LOG_DIR)
LOGGING = {
    'version': 1,  # 保留字
    'disable_existing_loggers': False,  # 禁用已经存在的logger实例
    # 日志文件的格式
    'formatters': {
        # 详细的日志格式
        'standard': {
            #  "format": "%(asctime)s - %(message)s",
            'format': '日志级别：{levelname},生成时间： {asctime} ,模块：{module} ,进程：{process:d},'
                      '线程：{thread:d} , 消息：{message}',
            'style': '{',
        },
    },
    # 过滤器
    'filters': {
        'require_debug_true': {
            '()': 'django.utils.log.RequireDebugTrue',
        },
    },
    # 处理器
    'handlers': {
        # 默认的
        'default': {
            'level': 'INFO',
            'class': 'logging.handlers.RotatingFileHandler',  # 保存到文件，自动切
            'filename': os.path.join(BASE_LOG_DIR, "message.log"),  # 日志文件
            'maxBytes': 1024 * 1024 * 50,  # 日志大小 50M
            'backupCount': 3,  # 最多备份几个
            'formatter': 'standard',
            'encoding': 'utf-8',
        },

    },
    'loggers': {
        # 默认的logger应用如下配置
        '': {
            'handlers': ['default'],  # 上线之后可以把'console'移除
            # 'level': 'WARNING',
            'level': 'INFO',
            'propagate': True,  # 向不向更高级别的logger传递
        },
    },
}