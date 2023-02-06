from django.contrib.auth.models import User
from .models import *

def duplicate_entries_preventer(factor,model):
    # factor is a dictionary {"email":"abc@ghmail.com"} < usage is here, arguments are supposed to be passed like this
    # Model is supposed to be passed as a string object like model="User" where User is the name of the model you are refering to
    if eval(model).objects.filter(**factor).exists():
        return True
    else:
        return False
def object_get(factor,model):
    # factor is a dictionary {"email":"abc@ghmail.com"} < usage is here, arguments are supposed to be passed like this
    # Model is supposed to be passed as a string object like model="User" where User is the name of the model you are refering to
    return eval(model).objects.get(**factor)

def object_creator(factor,model):
    # this function is to create objects in user defined models
    return eval(model).objects.create(**factor)