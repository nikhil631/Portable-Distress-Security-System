from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone
class contact_info(models.Model):
    roll=models.OneToOneField(User,to_field='id',on_delete=models.CASCADE)
    phone=models.CharField(max_length=10,unique=True)
    email=models.EmailField(unique=True)
    def __str__(self):
        return f"{self.roll_id}, {self.roll.username}"
class incoming_info(models.Model):
    roll=models.ForeignKey(contact_info,to_field='roll',on_delete=models.CASCADE)
    coordinate_x=models.CharField(max_length=354)
    coordinate_y=models.CharField(max_length=354)
    emergency=models.BooleanField()
    date_time=models.DateTimeField(default=timezone.now)
    def __str__(self):
        return f"{self.roll.roll.id} {self.roll.roll.username}"

class relation_users(models.Model):
    roll=models.ForeignKey(contact_info,to_field='roll',on_delete=models.CASCADE,related_name="rolls")
    relation=models.ForeignKey(contact_info,to_field='roll',on_delete=models.CASCADE,related_name="relation")
    def __str__(self):
        return f"{self.roll.roll.id} {self.roll.roll.username} -> {self.relation.roll.id} {self.relation.roll.username}"
class friend_requests(models.Model):
    user_from=models.ForeignKey(User,to_field='id',on_delete=models.CASCADE,related_name="user_from")
    user_to=models.ForeignKey(User,to_field='id',on_delete=models.CASCADE,related_name="user_to")
    date=models.DateTimeField()
    def __str__(self):
        return f"{self.roll.roll.id} {self.roll.roll.username} -> {self.relation.roll.id} {self.relation.roll.username}"
    