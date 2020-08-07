# -*- coding: UTF-8 -*-
"""services.py"""

from django.contrib.auth import models as auth_models
from django.shortcuts import get_object_or_404
from .serializers import UserSerializer
from .serializers import FollowSerializer
from .models import FollowRelationship


def get_people_user_follows(username):
    """
    Returns JSON format users that the given user follows.
    """
    user = auth_models.User.objects.get(username=username)
    ids = FollowRelationship.objects.filter(from_user=user) \
        .values_list('to_user_id', flat=True)
    queryset = auth_models.User.objects.filter(id__in=ids)
    serializer = UserSerializer(queryset, many=True)
    return serializer


def create_follow_relationship(validated_data):
    """
    Creates a new follow relationship.
    """
    serializer = FollowSerializer(data=validated_data)
    serializer.is_valid(raise_exception=True)
    serializer.save()
    return serializer


def delete_follow_relationship(validated_data):
    """
    Deletes an existing follow relationship.
    """
    relationship = get_object_or_404(FollowRelationship,
                                     from_user=validated_data.pop('from_user'),
                                     to_user=validated_data.pop('to_user'))
    relationship.delete()
