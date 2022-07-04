from django.test import TestCase
import pandas as pd
import glob, os

path = r'D:\notebook\django_\auto_luffy2\media\sm\data'
file = glob.glob(os.path.join(path, "202206*.xlsx"))
filenames = []
df = []
for filename in filenames:
    df.append(pd.read_excel(filename, index_col=None))
df_combine = pd.concat(df)
