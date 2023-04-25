from django.urls import path
from . import views
urlpatterns=[
    path('<str:coor_x>_<str:coor_y>_<int:emerg>/',views.api_add_data),
]