from django.contrib.auth.models import User
from .models import *
from django.core import mail
from django.template.loader import render_to_string
from django.utils.html import strip_tags
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
def object_filter(factor,model):
    # factor is a dictionary {"email":"abc@ghmail.com"} < usage is here, arguments are supposed to be passed like this
    # Model is supposed to be passed as a string object like model="User" where User is the name of the model you are refering to
    return eval(model).objects.filter(**factor)

def send_mail_to_relatives(users,cont):

    context={
        "first_name":users.first_name,
        "last_name":users.last_name,
        "coordinate_x":cont['x'],
        "coordinate_y":cont['y'],
        "emergency":cont['emerg'],
        "date":format(cont["datetime"],"%d-%m-%Y"),
        "time":format(cont["datetime"],'%I:%M %p')
    }
    
    mail.send_mail(
    subject=f"{users.first_name} {users.last_name} might be in danger",
    from_email=users.email,
    recipient_list=[object_get(factor={"roll_id":l},model="contact_info").email for l in [x.relation_id for x in object_filter(factor={"roll_id":cont["id"]},model="relation_users")]],
    html_message=render_to_string("security/email.html",context),
    message=strip_tags("security/emails.html")
    )
    print(render_to_string("security/email.html",context))
