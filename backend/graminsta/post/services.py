# -*- coding: UTF-8 -*-
"""services.py"""

from django.contrib.auth import get_user_model
from django.shortcuts import get_object_or_404
from core.serializers import UserSerializer
from .models import FollowRelationship


def get_people_user_follows(username):
    """
    Returns users that the given user follows.

    Parameters
    ------------
    username: str

    Returns
    -------
    follow_people: The QuerySet contains users that the
        given user follows.
    """
    user = get_user_model().objects.get(username=username)
    ids = FollowRelationship.objects.filter(from_user=user) \
        .values_list('to_user_id', flat=True)
    queryset = get_user_model().objects.filter(id__in=ids)
    following_people = UserSerializer(queryset, many=True)
    return following_people


def create_follow_relationship(request_user, target_user):
    """
    Creates a new follow relationship.

    Parameters
    ------------
    request_user: The user who triggered this action.
    target_user: The user who will be followed by the request_user.

    Returns
    -------
    follow_relationship: The new follow relationship object.
    """
    follow_relationship = FollowRelationship.objects.create(
        from_user=get_user_model().objects.get(pk=request_user),
        to_user=get_user_model().objects.get(pk=target_user)
    )
    return follow_relationship


def delete_follow_relationship(request_user, target_user):
    """
    Deletes an existing follow relationship.

    Parameters
    ------------
    request_user: The user who triggered this action.
    target_user: The user who will be unfollowed by the request_user.
    """
    relationship = get_object_or_404(FollowRelationship,
                                     from_user=request_user,
                                     to_user=target_user)
    relationship.delete()
