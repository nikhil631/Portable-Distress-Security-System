from django.contrib.auth.models import User
from .models import *
from django.core import mail
from django.core.cache import cache
from django.db.models import Q
from django.template.loader import render_to_string
from django.utils.html import strip_tags
import pywhatkit

def custom_commands(command:str):
    """
    This function taked command as string input,
    It just executes all your written commands from this file,
    The reason for this is to make your views.py cleaner,
    By importing most functions in another file and use when needed
    """
    exec(command)

def cache_object_set(key:str,value:any,Default_Timeout:int=None,NX:bool=False):
    """
    Function to set object in cache,
    both NX and EX methods are supported,
    """
    if NX:
        cache.add(key,value,Default_Timeout)
    else:
        cache.set(key,value,Default_Timeout)

def cache_object_get(key:str):
    """
    Function to set object in cache,
    both NX and EX methods are supported,
    """
    return cache.get(key)


def cache_object_get_or_set(key:str,value:any,Default_Timeout:int=None):
    """
    Get or Set, If value doesn't exist in cache it creates the value,
    If value already exists in cache it just retrieves it
    """
    return cache.get_or_set(key,value,Default_Timeout)


def object_exists(factor,model):
    # factor is a dictionary {"email":"abc@ghmail.com"} < usage is here, arguments are supposed to be passed like this
    # Model is supposed to be passed as a string object like model="User" where User is the name of the model you are refering to
    return eval(model).objects.filter(**factor).exists()
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

def object_filter_orderby(factor,model,orderby):
    # factor is a dictionary {"email":"abc@ghmail.com"} < usage is here, arguments are supposed to be passed like this
    # Model is supposed to be passed as a string object like model="User" where User is the name of the model you are refering to
    return eval(model).objects.filter(**factor).order_by(orderby)

def object_all(model):
    # factor is a dictionary {"email":"abc@ghmail.com"} < usage is here, arguments are supposed to be passed like this
    # Model is supposed to be passed as a string object like model="User" where User is the name of the model you are refering to
    return eval(model).objects.all()

def object_remove(factor,model):
    # factor is a dictionary {"email":"abc@ghmail.com"} < usage is here, arguments are supposed to be passed like this
    # Model is supposed to be passed as a string object like model="User" where User is the name of the model you are refering to
    return eval(model).objects.filter(**factor)

def send_mail_to_relatives(user):
    emails_relations=[x.relation.email for x in object_filter(factor={"roll_id":user.roll},model="relation_users")]
    # roll.roll.id means going from table this table incoming_info(roll)->contact_info(roll)->auth_user(id)
    if len(emails_relations)!=0:
        context={
            "first_name":user.roll.roll.first_name,
            "last_name":user.roll.roll.last_name,
            "email":user.roll.roll.email,
            "coordinate_x":user.coordinate_x,
            "coordinate_y":user.coordinate_y,
            "emergency":user.emergency,
            "date":format(user.date_time,"%d-%m-%Y"),
            "time":format(user.date_time,'%I:%M %p')
        }

        mail.send_mail(
        subject=f"{context['first_name']} {context['last_name']} might be in danger",
        from_email=context["email"],
        recipient_list=emails_relations,
        html_message=render_to_string("security/email.html",context),
        message=strip_tags("security/emails.html")
        )

def send_mobile_messages(user):
    context={
    "first_name":user.roll.roll.first_name,
    "last_name":user.roll.roll.last_name,
    "coordinate_x":user.coordinate_x,
    "coordinate_y":user.coordinate_y,
    "emergency":user.emergency,
    "date":format(user.date_time,"%d-%m-%Y"),
    "time":format(user.date_time,'%I:%M %p')
    }
    phone_relations=[x.relation.phone for x in object_filter(factor={"roll_id":user.roll},model="relation_users")]
    if len(phone_relations)!=0:
        for x in phone_relations:
            pywhatkit.sendwhatmsg_instantly(f"+91{x}",message=f"{context['first_name']} {context['last_name']} is in distress, X coordinate is {context['coordinate_x']}, Y coordinate is {context['coordinate_y']}, Date for this action is {context['date']} and time is {context['time']}, Click this link for Location https://www.google.com/maps/search/?api=1&query={context['coordinate_x']},{context['coordinate_y']}",tab_close=True)