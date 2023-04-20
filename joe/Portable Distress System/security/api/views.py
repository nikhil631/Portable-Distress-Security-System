from django.shortcuts import render
from rest_framework.decorators import api_view 
from rest_framework.response import Response
import datetime 
from security.miscellaneous import *
from django.conf import settings
# Create your views here.
@api_view(["POST"])
def api_add_data(request,coor_x,coor_y,emerg,ids,datetime=datetime.datetime.now()):
    if object_exists({"id":ids},model="User"):
        obj=object_filter({'roll_id':ids},"relation_users")
        context={
                "first_name":obj[0].roll.roll.first_name,
                "last_name":obj[0].roll.roll.last_name,
                "coordinate_x":coor_x,
                "coordinate_y":coor_y,
                "emergency":emerg,
                "date":format(datetime,"%d-%m-%Y"),
                "time":format(datetime,'%I:%M %p'),
                "id":ids,
                "email":obj[0].roll.email,
                "phone_relations":[x.relation.phone for x in obj],
                "emails_relations":[x.relation.email for x in obj],
            }
        cache_object_queue_add(settings.REDIS_WORKER_QUEUE,context)
        object_creator(factor={"roll_id":ids,"coordinate_x":coor_x,"coordinate_y":coor_y,"emergency":emerg,"date_time":datetime},model="incoming_info")
        cache_object_delete(f"user_home:{context['id']}")
        return Response(context,status=200)
    else:
        return Response({},status=403)
    
