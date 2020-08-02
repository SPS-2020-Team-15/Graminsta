# -*- coding: UTF-8 -*-
"""utils.py"""
from django.contrib.auth import models as auth_models
from .models import FollowRelationship


def get_people_user_follows(user):
    """
    Returns a QuerySet representing the users that the given user follows.
    """
    ids = FollowRelationship.objects.filter(from_user=user)\
        .values_list('to_user', flat=True)
    return auth_models.User.objects.filter(id__in=ids)


def get_people_following_user(user):
    """
    Returns a QuerySet representing the users that follow the given user.
    """
    ids = FollowRelationship.objects.filter(to_user=user)\
        .values_list('from_user', flat=True)
    return auth_models.User.objects.filter(id__in=ids)
