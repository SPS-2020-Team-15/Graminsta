# -*- coding: UTF-8 -*-

"""
Services for core module.
"""

from django.contrib.auth import authenticate, get_user_model
from rest_framework.authtoken.models import Token
from .serializers import UserSerializer
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
    user = UserSerializer.create(
        UserSerializer(), validated_data=user_data)
    user_info = UserInfo.objects.create(
        user=user,
        age=validated_data.pop('age'),
        gender=validated_data.pop('gender')
    )
    return user_info


def get_all_users():
    """
    Returns all user's in database.

    Returns
    --------------
    all_users: The QuerySet containers all user object
    """
    all_users = get_user_model().objects.all()
    return all_users


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
