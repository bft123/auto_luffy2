from django import forms

class BootStrap:
    # name = forms.CharField(min_length=3, label="用户名")

    # password = forms.CharField(label="密码",validators=)

    bootstrap_exclude_fields = []

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # 循环找到所有的插件，添加了样式
        for name, field in self.fields.items():
            # print(name, field)
            # if name == "password":
            #     continue
            if name in self.bootstrap_exclude_fields:
                continue
            if field.widget.attrs:
                field.widget.attrs['class'] = 'form-control'
                field.widget.attrs['placeholder'] = field.label
            else:
                field.widget.attrs = {'class': 'form-control', 'placeholder': field.label}

class BootStrapModelForm(BootStrap, forms.ModelForm):
    pass

class BootStrapForm(BootStrap, forms.Form):
    pass