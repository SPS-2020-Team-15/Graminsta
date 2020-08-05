# -*- coding: UTF-8 -*-

"""
Here defines model serializers.
"""

from django.contrib.auth import models as auth_models
from rest_framework import serializers
from .models import UserInfo


class UserSerializer(serializers.ModelSerializer):
    """
    Serializer that serializes/deserializes User object
    """

    class Meta:
        """
        Meta Information
        """
        model = auth_models.User
        fields = (
            'username',
            'first_name',
            'last_name',
            'email',
            'password',
        )
        extra_kwargs = {'password': {'write_only': True}}


class UserInfoSerializer(serializers.ModelSerializer):
    """
    Serializer that serializes/deserializes UserInfo object
    """
    user = UserSerializer(required=True)

    class Meta:
        """
        Meta Information
        """
        model = UserInfo
        fields = (
            'user',
            'age',
            'gender',
        )
