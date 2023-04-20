from django.shortcuts import render,HttpResponseRedirect
from .forms import *
from .miscellaneous import *
from django.contrib.auth import authenticate,login,logout
from django.contrib import messages
import datetime

def registration(request):
    form=user_create()
    if request.method=="POST":
        form=user_create(request.POST)
        if object_exists(factor={'email':request.POST["email"]},model="User") or object_exists(factor={'username':request.POST["username"]},model="User"):
            messages.error(request,"Email or Username Already Exists, Please use a different email")
            return HttpResponseRedirect("/registration/")
        if form.is_valid():
            form.save()
            object_creator(factor={"roll_id":object_get({'username':request.POST["username"]},"User").id,'phone':request.POST["phone"],'email':request.POST["email"]},model="contact_info")
            cache_object_delete("all_users")
            messages.success(request,"Signed-Up Succesfully")
            return HttpResponseRedirect("/login/")
    context={
        'form':form,
    }
    return render(request,"security/registration.html",context)

def home(request):
    context={}
    if cache_object_exists(f"django.contrib.sessions.cache{request.session.session_key}"):
        context={
            "data":cache_object_get_or_set(f"user_home:{request.user.id}",object_filter_orderby(factor={"roll_id":request.user.id},model="incoming_info",orderby="-id"),settings.CACHES_TTL),
            "authenticated":1,     
        }
    return render(request,"security/home.html",context)

def root(request):
    return HttpResponseRedirect("/home")

def logins(request):
    form=user_sign()
    if request.method=="POST":
        users=authenticate(username=request.POST["username"],password=request.POST["password"])
        if users != None:
            login(request,users)
            messages.success(request,f"Welcome {request.user.first_name}, You have Logged In Succesfully")
            return HttpResponseRedirect("/")
        else:
            messages.error(request,"Email/Password does not exist")
            return HttpResponseRedirect("/login/")
    context={
        "form":form,
        }
    return render(request,"security/login.html",context)

def logouts(request):
    if cache_object_exists(f"django.contrib.sessions.cache{request.session.session_key}"):
        logout(request)
        messages.success(request,"Logout Successfull")
        return HttpResponseRedirect("/login/")
    else:
        messages.error(request,"Logout failed, Not Logged in currently")
        return HttpResponseRedirect("/login/")

# def add_data(request,coor_x,coor_y,emerg,ids,datetime=datetime.datetime.now()):
#     obj=object_filter({'roll_id':ids},"relation_users")
#     context={
#             "first_name":obj[0].roll.roll.first_name,
#             "last_name":obj[0].roll.roll.last_name,
#             "coordinate_x":coor_x,
#             "coordinate_y":coor_y,
#             "emergency":emerg,
#             "date":format(datetime,"%d-%m-%Y"),
#             "time":format(datetime,'%I:%M %p'),
#             "id":ids,
#             "email":obj[0].roll.email,
#             "phone_relations":[x.relation.phone for x in obj],
#             "emails_relations":[x.relation.email for x in obj],
#         }
#     cache_object_queue_add(settings.REDIS_WORKER_QUEUE,context)
#     object_creator(factor={"roll_id":ids,"coordinate_x":coor_x,"coordinate_y":coor_y,"emergency":emerg,"date_time":datetime},model="incoming_info")
#     cache_object_delete(f"user_home:{context['id']}")
#     return render(request,"security/data_add.html",context)

def add_relatives(request):
    context={
        "people":cache_object_get_or_set(f"all_users",object_all("User"),settings.CACHES_TTL),
        }
    if request.method=="POST":
        try:
            if str(request.POST["relatives"]) in [str(x.relation_id) for x in object_filter(factor={"roll_id":request.user.id},model="relation_users")]:
                raise Exception([1062,"Duplication found"])
            object_creator(factor={"roll_id":request.user.id,"relation_id":request.POST["relatives"]},model="relation_users")
            messages.success(request,"Relations added Successfully")
            return HttpResponseRedirect("/add_relatives/")
        except Exception as e:
            if e.args[0]==1062 or e.args[0][0]==1062:
                messages.error(request,"This relation already exists, Please try someone else")
                return HttpResponseRedirect("/add_relatives/")                
    return render(request,"security/relatives_add.html",context)

def rem_relatives(request):
    if cache_object_exists(f"django.contrib.sessions.cache{request.session.session_key}"):
        relatives=[x for x in object_filter(factor={"roll_id":request.user.id},model="relation_users")]
        if request.method=="POST":
            relatives=[object_get(factor={"roll_id":request.user.id,"relation_id":x},model="relation_users").delete() for x in request.POST if request.POST[x]=="on"]
            return HttpResponseRedirect("/rem_relatives/")  
        context={
            "relatives":relatives,
            "authenticated":1,
            }
    else:
        context={}
    return render(request,"security/rem_relatives.html",context)
