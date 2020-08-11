# -*- coding: UTF-8 -*-

"""
Services for core module.
"""

from .serializers import UserSerializer
from .serializers import UserInfoSerializer
from .models import UserInfo
from django.contrib.auth import authenticate, login
from rest_framework.authtoken.models import Token
import json

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
    request_form = json.loads(request.body)
    user = authenticate(username=request_form["username"], password=request_form["password"])
    if user is not None:
        login(request, user)        
        try:
            token = Token.objects.get(user=user)
            token.delete()
            token = Token.objects.create(user=user)
        except:
            token = Token.objects.create(user=user)
        return token.key
    else:
        return None
