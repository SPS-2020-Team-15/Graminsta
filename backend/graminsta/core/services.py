# -*- coding: UTF-8 -*-

"""
Services for core module.
"""

from rest_framework.authtoken.models import Token
from django.contrib.auth import authenticate, login
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


def user_authentication(request):
    """User Authentication

    Parameters
    ----------
    request: rest_framework.request.Request
        Request from the frontend

    Returns
    -------
    token.key: String format
        if the authentication passed.
    None if the authentication failed.
    """
    data = request.data
    user = authenticate(
        request,
        username=data.get("username", ""),
        password=data.get("password", ""))
    if user is not None:
        login(request, user)
        try:
            token = Token.objects.get(user=user)
            token.delete()
            token = Token.objects.create(user=user)
        except Token.DoesNotExist:
            token = Token.objects.create(user=user)
        return token.key
    return None
