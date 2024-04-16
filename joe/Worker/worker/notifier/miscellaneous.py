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

def send_mail_to_relatives(context):
    # roll.roll.id means going from table this table incoming_info(roll)->contact_info(roll)->auth_user(id)
    if len(context['emails_relations'])!=0:
        mail.send_mail(
        subject=f"{context['first_name']} {context['last_name']} is in distress",
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
            try:
                request=json.loads(request[1])
                print("entries found")
                send_mail_to_relatives(request)
                send_mobile_messages(request)
            except Exception as e:
                print(e)
                pass

scheduler = BackgroundScheduler()
def start_scheduler():
    scheduler.add_job(notifiers, 'date', run_date=datetime.datetime.now())
    scheduler.start()

def stop_scheduler():
    scheduler.shutdown()

