from django.db import models
from django.contrib.auth.models import User

class contact_info(models.Model):
    roll=models.OneToOneField(User,to_field='id',on_delete=models.CASCADE)
    phone=models.CharField(max_length=10)
    email=models.EmailField()