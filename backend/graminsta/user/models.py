# -*- coding: UTF-8 -*-

"""models.py
"""

from django.db import models


# Create your models here.
class User(models.Model):
    """User Class
    """
    user_name = models.CharField(max_length=20)
    password = models.CharField(max_length=20)
    email = models.EmailField()
