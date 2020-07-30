# -*- coding: UTF-8 -*-
"""models.py"""
from django.db import models
from django.contrib.auth.models import User


class Post(models.Model):
    """A Post is usually user-generated which contains information
    like an image, and some description to the image"""
    publisher = models.ForeignKey(User, on_delete=models.CASCADE,
                                  related_name="published_posts")
    description = models.TextField()
    img = models.ImageField(upload_to='img')
    marked_users = models.ManyToManyField(User, related_name="marking_users")


class Comment(models.Model):
    """A comment is usually user-generated under other user's post,
    which contains some text"""
    publisher = models.ForeignKey(User, on_delete=models.CASCADE)
    post = models.ForeignKey(Post, on_delete=models.CASCADE)
    time = models.DateTimeField(auto_now=True)
