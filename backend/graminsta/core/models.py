# -*- coding: UTF-8 -*-

"""models.py
"""

from django.db import models
from django.contrib.auth import models as auth_models


# Create your models here.
class UserInfo(models.Model):
    """UserInfo Class
    """
    GENDER_MALE = 0
    GENDER_FEMALE = 1
    GENDER_CHOICES = ((GENDER_MALE, 'Male'), (GENDER_FEMALE, 'Female'))

    user = models.OneToOneField(auth_models.User, on_delete=models.CASCADE)
    age = models.PositiveIntegerField()
    gender = models.IntegerField(choices=GENDER_CHOICES)

    def __str__(self):
        return self.user.username
