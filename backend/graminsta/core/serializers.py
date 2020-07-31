# -*- coding: UTF-8 -*-

"""
Here defines model serializers.
"""

from django.contrib.auth import models as auth_models
from rest_framework import serializers
from .models import UserInfo


class UserSerializer(serializers.ModelSerializer):
    """
    UserSerializer defined for User model.
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


class UserInfoSerializer(serializers.ModelSerializer):
    """
    UserInfoSerializer for  UserInfo class
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

    def create(self, validated_data):
        """
        Overriding the default create method of the Model Serializer.
        :param validated_data: data containing all the details of student
        :return: returns a successfully created Userinfo record
        """
        user_data = validated_data.pop('user')
        user = UserSerializer.create(
            UserSerializer(), validated_data=user_data)
        user_info = UserInfo.objects.update_or_create(
            user=user,
            age=validated_data.pop('age'),
            gender=validated_data.pop('gender')
        )[0]
        return user_info
