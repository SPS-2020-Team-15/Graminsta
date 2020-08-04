# -*- coding: UTF-8 -*-

"""
Services for core module.
"""

from .serializers import UserSerializer
from .serializers import UserInfoSerializer
from .models import UserInfo


def create_userinfo(validated_data):
    """Create or update a UserInfo in databaase.

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
    if userinfo_serializer.is_valid(raise_exception=ValueError):
        user_data = validated_data.pop('user')
        user = UserSerializer.create(
            UserSerializer(), validated_data=user_data)
        user_info = UserInfo.objects.update_or_create(
            user=user,
            age=validated_data.pop('age'),
            gender=validated_data.pop('gender')
        )[0]
        return {'user_info': user_info}
    return {'error': userinfo_serializer.errors}
