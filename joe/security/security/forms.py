from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User

class user_create(UserCreationForm):
    first_name=forms.CharField(max_length=300,required=True)
    last_name=forms.CharField(max_length=300,required=True)
    phone=forms.CharField(required=True,min_length=10,max_length=10)
    class Meta():
        model=User
        fields=['username','first_name','last_name','email','phone','password1','password2']
class user_sign(forms.Form):
    username=forms.CharField(widget=forms.TextInput(attrs={'style':'width:10%'}),max_length=400)
    password=forms.CharField(widget=forms.PasswordInput(attrs={'style':'width:10%'}),max_length=400)
class add_rel(forms.Form):
    choices=[(f"{x.id}",f"{x.username}") for x in User.objects.all()]
    relatives=forms.ChoiceField(choices=choices)