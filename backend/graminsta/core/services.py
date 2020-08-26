# -*- coding: UTF-8 -*-

"""
Services for core module.
"""

from rest_framework.authtoken.models import Token
from django.contrib.auth import authenticate
from django.contrib.auth import models as auth_models
from .serializers import UserInfoSerializer
from .models import UserInfo


def create_userinfo(validated_data):
    """Create or update a UserInfo in database.

    Parameters
    ----------
    validated_data: json format
        data containing all the details of User

    Returns
    -------
    user_info: json format
        a successfully created User record
    """
    userinfo_serializer = UserInfoSerializer(data=validated_data)
    userinfo_serializer.is_valid(raise_exception=True)
    user_data = validated_data.pop('user')
    user = auth_models.User.objects.create_user(**user_data)
    user_info = UserInfo.objects.create(
        user=user,
        age=validated_data.pop('age'),
        gender=validated_data.pop('gender')
    )
    return user_info


def create_authentication_token(data):
    """User Authentication

    Parameters
    ----------
    data: json format
        Data containing username and password

    Returns
    -------
    token: Token
        if the authentication passed.
    None if the authentication failed.
    """
    user = authenticate(
        username=data.get("username", ""),
        password=data.get("password", ""))
    if user is not None:
        try:
            Token.objects.get(user=user).delete()
        except Token.DoesNotExist:
            pass
        return Token.objects.create(user=user)
    return None


def get_user_info(user):
    """Get User Info from the database.

    Parameters
    ----------
    data: user
        A User Object

    Returns
    -------
    user_info: UserInfo
        A UserInfo Object
    """
    user_info = UserInfo.objects.get(user=user)
    return user_info
