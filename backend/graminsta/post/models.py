# -*- coding: UTF-8 -*-
"""This models.py defines the model of our post app"""

from django.db import models
from django.contrib.auth import models as auth_models


class Post(models.Model):
    """
    A Post is usually auth_models.User generated which contains information 
        like an image,and some description to the image
    """
    publisher = models.ForeignKey(
        auth_models.User,
        on_delete=models.CASCADE,
        related_name="published_posts")
    time = models.DateTimeField(auto_now=True)
    marked_user = models.ManyToManyField(
        auth_models.User, related_name="marked_post")
    image_url = models.TextField()
    description = models.TextField()
    stars = models.IntegerField()


class Comment(models.Model):
    """
    A comment is auth_models.Users' feedback for a given post
    """
    publisher = models.ForeignKey(auth_models.User, on_delete=models.CASCADE)
    time = models.DateTimeField(auto_now=True)
    post = models.ForeignKey(Post, on_delete=models.CASCADE)
    content = models.TextField()


class Following(models.Model):
    """
    Follow represents the relationship between follower and target
    """
    target = models.ForeignKey(
        auth_models.User, on_delete=models.CASCADE, related_name="followed_by")
    follower = models.ForeignKey(
        auth_models.User, on_delete=models.CASCADE, related_name="follow")
