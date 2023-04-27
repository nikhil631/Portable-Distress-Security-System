from rest_framework.decorators import api_view,authentication_classes,permission_classes
from rest_framework.response import Response
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
import datetime 
from security.miscellaneous import *
from django.conf import settings


@api_view(["POST"])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def api_add_data(request,coor_x,coor_y,emerg):
    datetimes=datetime.datetime.now()
    obj=object_filter({'roll_id':request.user.id},'relation_users')
    context={
            "first_name":request.user.first_name,
            "last_name":request.user.last_name,
            "coordinate_x":coor_x,
            "coordinate_y":coor_y,
            "emergency":emerg,
            "date":format(datetimes,"%d-%m-%Y"),
            "time":format(datetimes,'%I:%M %p'),
            "id":request.user.id,
            "email":request.user.email,
            "phone_relations":[x.relation.phone for x in obj],
            "emails_relations":[x.relation.email for x in obj],
        }
    cache_object_queue_add(settings.REDIS_WORKER_QUEUE,context)
    object_creator(factor={"roll_id":request.user.id,"coordinate_x":coor_x,"coordinate_y":coor_y,"emergency":emerg,"date_time":datetimes},model="incoming_info")
    cache_object_delete(f"user_home:{context['id']}")
    return Response(context,status=200)
