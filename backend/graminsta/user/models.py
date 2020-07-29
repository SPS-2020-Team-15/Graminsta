# -*- coding: UTF-8 -*-

"""models.py
"""

from django.db import models
from django.contrib.auth.models import User


# Create your models here.
class UserInfo(models.Model):
    """UserInfo Class
    """
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    age = models.IntegerField()
    gender = models.CharField(max_length=10)
    reg_time = models.DateTimeField(auto_now=True)
    following_user = models.ManyToManyField("self", symmetrical=False)
