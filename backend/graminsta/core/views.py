# -*- coding: UTF-8 -*-

"""
Register and Login.
"""
from django.contrib.auth import get_user_model
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from .serializers import UserSerializer, UserInfoSerializer
from .services import create_userinfo, create_authentication_token, get_user_info


class UserInfoRecordView(APIView):
    """
    A class based view for creating and fetching UserInfo Record.
    """

    def post(self, request):
        """Creates a UserInfo record

        Parameters
        ----------
        request: json format
            Data containing request information, or None.

        Returns
        -------
        response: json format
            Newly created user_info
        """
        user_info = create_userinfo(request.data)
        return Response(
            UserInfoSerializer(user_info).data,
            status=status.HTTP_201_CREATED
        )

    @staticmethod
    def get(request):
        """Get all the users

        Parameters
        ----------
        request: GET request

        Returns
        -------
        response: json format users
        """
        users = get_user_model().objects.all()
        return Response(UserSerializer(users, many=True).data)


class UserLoginView(APIView):
    """
    A class based view for User Login.
    """

    def post(self, request):
        """User Authentication

        Parameters
        ----------
        request: json format
            Data containing request information, or None.

        Returns
        -------
        response: json format
            return "Login Failed" if authentication failed.
            return the token if the authentication passed.
        """
        token = create_authentication_token(request.data)
        if token is None:
            return Response(
                "Login Failed",
                status=status.HTTP_401_UNAUTHORIZED
            )
        return Response(
            {"token": token.key},
            status=status.HTTP_200_OK
        )

class UserInfoView(APIView):
    """
    A class based view for User Info.
    """

    def get(self, request):
        """Get the UserInfo of the request user.

        Parameters
        ----------
        request: GET request

        Returns
        -------
        response: json format user_info
        """
        user_info = get_user_info(request.user)
        return Response(UserInfoSerializer(user_info).data)

