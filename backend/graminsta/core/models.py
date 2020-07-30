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
    age = models.PositiveIntegerField()

    GENDER_MALE = 0
    GENDER_FEMALE = 1
    GENDER_CHOICES = [(GENDER_MALE, 'Male'), (GENDER_FEMALE, 'Female')]
    gender = models.IntegerField(choices=GENDER_CHOICES)
