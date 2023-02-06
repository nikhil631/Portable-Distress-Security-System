from django.shortcuts import render,HttpResponseRedirect
from .models import *
from .forms import *
from .miscellaneous import *
from django.contrib.auth import authenticate,login,logout
from django.contrib import messages

def registration(request):
    form=user_create()
    if request.method=="POST":
        form=user_create(request.POST)
        if duplicate_entries_preventer(factor={'email':request.POST["email"]},model="User"):
            messages.error(request,"Email Already Exists, Please use a different email")
            return HttpResponseRedirect("/registration/")
        if form.is_valid():
            form.save()
            object_creator(factor={"roll_id":object_get({'username':request.POST["username"]},"User").id,'phone':request.POST["phone"],'email':request.POST["email"]},model="contact_info")
            messages.success(request,"Signed-Up Succesfully")
            return HttpResponseRedirect("/login/")
    context={
        'form':form,
    }
    return render(request,"security/registration.html",context)

def home(request):
    context={}
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
    if request.user.is_authenticated:
        logout(request)
        messages.success(request,"Logout Successfull")
        return HttpResponseRedirect("/login/")
    else:
        messages.error(request,"Logout failed, Not Logged in currently")
        return HttpResponseRedirect("/login/")

