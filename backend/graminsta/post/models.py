# -*- coding: UTF-8 -*-
"""models.py"""
from django.db import models
from django.contrib.auth import models as auth_models
from django.conf import settings


class Post(models.Model):
    """
    A Post is usually user-generated which contains information
    like an image, and some description to the image.
    """
    publisher = models.ForeignKey(auth_models.User, on_delete=models.CASCADE,
                                  related_name="published_posts")
    description = models.TextField()
    lon = models.FloatField(blank=True, null=True)
    lat = models.FloatField(blank=True, null=True)
    img = models.ImageField(settings.MEDIA_ROOT)
    marked_user = models.ManyToManyField(auth_models.User,
                                         related_name="marking_users",
                                         blank=True, null=True)
    mention_user = models.ManyToManyField(auth_models.User,
                                          related_name="mentioned_by_post",
                                          blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    shared_mode = models.TextField()
    kudos = models.IntegerField(default=0)

    def __str__(self):
        return '%s: %s' % (self.publisher.username,
                           self.description)


class Comment(models.Model):
    """
    A comment is usually user-generated under other user's post,
    which contains some text.
    """
    publisher = models.ForeignKey(auth_models.User, on_delete=models.CASCADE)
    post = models.ForeignKey(Post, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)


class FollowRelationship(models.Model):
    """
    A follow relationship is a single directed edge in the social graph.
    Usually represented as "A is following B".
    """
    from_user = models.ForeignKey(auth_models.User,
                                  related_name='following_users',
                                  on_delete=models.CASCADE)
    to_user = models.ForeignKey(auth_models.User,
                                related_name='follower_users',
                                on_delete=models.CASCADE)
    date_added = models.DateTimeField(auto_now=True)

    def __str__(self):
        return '%s is following %s' % (self.from_user.username,
                                       self.to_user.username)

    class Meta:
        """
        Meta configuration for FollowRelationShip model.

        It ensures the uniqueness of the relationship (to_user, from_user).
        """
        unique_together = (('to_user', 'from_user'),)
