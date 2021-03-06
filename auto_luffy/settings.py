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

# #################### ?????????????????? #######################
# ?????????????????????
RBAC_USER_MODLE_CLASS = "app01.models.UserInfo"
# ?????????Session????????????key
PERMISSION_SESSION_KEY = "luffy_permission_url_list_key"
# ?????????Session????????????key
MENU_SESSION_KEY = "luffy_permission_menu_key"

# ?????????
VALID_URL_LIST = [
    '/login/',
    '/admin/.*'
]

# ??????????????????????????????URL
NO_PERMISSION_LIST = [
    '/index/',
    '/logout/',
]

# ????????????????????????URL???????????????URL
AUTO_DISCOVER_EXCLUDE = [
    '/admin/.*',
    '/login/',
    '/logout/',
    '/index/',
]

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

# ??????media 3
import os

MEDIA_ROOT = os.path.join(BASE_DIR, "media")
MEDIA_URL = "/media/"

# ????????????
BASE_LOG_DIR = os.path.join(BASE_DIR, "log")
if not os.path.exists(BASE_LOG_DIR):
    os.mkdir(BASE_LOG_DIR)
LOGGING = {
    'version': 1,  # ?????????
    'disable_existing_loggers': False,  # ?????????????????????logger??????
    # ?????????????????????
    'formatters': {
        # ?????????????????????
        'standard': {
            #  "format": "%(asctime)s - %(message)s",
            'format': '???????????????{levelname},??????????????? {asctime} ,?????????{module} ,?????????{process:d},'
                      '?????????{thread:d} , ?????????{message}',
            'style': '{',
        },
    },
    # ?????????
    'filters': {
        'require_debug_true': {
            '()': 'django.utils.log.RequireDebugTrue',
        },
    },
    # ?????????
    'handlers': {
        # ?????????
        'default': {
            'level': 'INFO',
            'class': 'logging.handlers.RotatingFileHandler',  # ???????????????????????????
            'filename': os.path.join(BASE_LOG_DIR, "message.log"),  # ????????????
            'maxBytes': 1024 * 1024 * 50,  # ???????????? 50M
            'backupCount': 3,  # ??????????????????
            'formatter': 'standard',
            'encoding': 'utf-8',
        },

    },
    'loggers': {
        # ?????????logger??????????????????
        '': {
            'handlers': ['default'],  # ?????????????????????'console'??????
            # 'level': 'WARNING',
            'level': 'INFO',
            'propagate': True,  # ????????????????????????logger??????
        },
    },
}