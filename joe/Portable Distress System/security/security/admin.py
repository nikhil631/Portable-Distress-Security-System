from django.contrib import admin
from .models import *
# Register your models here.
admin.site.register([contact_info,incoming_info,relation_users])