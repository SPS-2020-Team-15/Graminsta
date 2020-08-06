# -*- coding: UTF-8 -*-

"""
Here defines model serializers.
"""

from django.contrib.auth import models as auth_models
from rest_framework import serializers


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
