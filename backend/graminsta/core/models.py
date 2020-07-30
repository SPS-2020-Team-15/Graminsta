# -*- coding: UTF-8 -*-

"""models.py
"""

from django.db import models
from django.contrib.auth import models as auth_models


# Create your models here.
class UserInfo(models.Model):
    """UserInfo Class
    """
    user = models.OneToOneField(auth_models.User, on_delete=models.CASCADE)
    age = models.IntegerField()
    gender = models.CharField(max_length=10)
