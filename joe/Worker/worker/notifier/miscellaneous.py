from django.contrib.auth.models import User
from .models import *
from django.core import mail
from django.core.cache import cache
from django.db.models import Q
from django.template.loader import render_to_string
from django.utils.html import strip_tags
from twilio.rest import Client
from django.conf import settings
import json
import redis,datetime
from apscheduler.schedulers.background import BackgroundScheduler

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


def cache_object_get(key:str)->any:
    """
    Function to set object in cache,
    both NX and EX methods are supported,
    """
    return cache.get(key)


def cache_object_get_or_set(key:str,value:any,Default_Timeout:int=None)->any:
    """
    Get or Set, If value doesn't exist in cache it creates the value,
    If value already exists in cache it just retrieves it
    """
    return cache.get_or_set(key,value,Default_Timeout)

def cache_object_exists(key:str)->bool:
    """
    Object exists in cache or not
    """
    return cache.has_key(key)

def cache_object_delete(key:str):
    """
    Function to delete a key from the cache
    """
    return cache.delete(key)

def cache_object_queue_add(key:str,value:any):
    """
    key should be name of queue,
    value, 0th element must be your value
    1th element must be the data type your sending
    """
    if type(value)==dict:
        value=json.dumps(value)
    redis_conn = redis.StrictRedis.from_url(settings.CACHES['default']['LOCATION'])
    redis_conn.rpush(key,value)

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

def send_mail_to_relatives(context):
    # roll.roll.id means going from table this table incoming_info(roll)->contact_info(roll)->auth_user(id)
    if len(context['emails_relations'])!=0:
        mail.send_mail(
        subject=f"{context['first_name']} {context['last_name']} might be in danger",
        from_email="nikhil.tomar.22cse@bmu.edu.in",
        recipient_list=context['emails_relations'],
        html_message=render_to_string("notifier/email.html",context),
        message=strip_tags("notifier/email.html"),
        )

def send_mobile_messages(context):
    # Twillio Implementation below
    if len(context['phone_relations'])!=0:
        client=Client(settings.WHATSAPP_API_SID,settings.WHATSAPP_API_AUTH_TOKEN)
        for x in context['phone_relations']:
            client.messages.create(from_="whatsapp:+14155238886",to=f"whatsapp:+91{x}",body=f"{context['first_name']} {context['last_name']} is in distress, X coordinate is {context['coordinate_x']}, Y coordinate is {context['coordinate_y']}, Date for this action is {context['date']} and time is {context['time']}, Click this link for Location https://www.google.com/maps/search/?api=1&query={context['coordinate_x']},{context['coordinate_y']}")

def notifiers():
    redis_conn = redis.StrictRedis.from_url(settings.CACHES["default"]["LOCATION"])
    while True:
        request=redis_conn.brpop(settings.REDIS_WORKER_QUEUE)
        if request!=None:
            request=json.loads(request[1])
            try:
                print("entries found")
                send_mail_to_relatives(request)
                send_mobile_messages(request)
            except Exception as e:
                print(e)

scheduler = BackgroundScheduler()
def start_scheduler():
    scheduler.add_job(notifiers, 'date', run_date=datetime.datetime.now())
    scheduler.start()

def stop_scheduler():
    scheduler.shutdown()

