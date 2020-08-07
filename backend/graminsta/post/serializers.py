# -*- coding: UTF-8 -*-
"""serializers.py"""

from django.contrib.auth import models as auth_models
from rest_framework import serializers
from .models import FollowRelationship


class FollowSerializer(serializers.ModelSerializer):
    """
    Serializer that serializes/deserializes
    FollowRelationship object
    """
    class Meta:
        """
        Meta Information
        """
        model = FollowRelationship
        fields = (
            'from_user', 'to_user'
        )


class UserSerializer(serializers.ModelSerializer):
    """
    Serializer that serializes/deserializes username
    """
    class Meta:
        """
        Meta Information
        """
        model = auth_models.User
        fields = ('username',)
        read_only_fields = ('username',)
