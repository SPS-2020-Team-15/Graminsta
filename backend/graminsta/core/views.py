# -*- coding: UTF-8 -*-

"""
Register and Login.
"""
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .services import create_userinfo, create_authentication_token, \
    get_all_username
from .serializers import UserInfoSerializer


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

    def get(self, request):
        """Get username based on request's requirements

        Parameters
        --------------
        request: json format
            Data containing request information, or None

        Returns
        --------------
        response: json format
            username of all users that satisfy the requirements
        """
        username = get_all_username()
        return Response(
            username,
            status=status.HTTP_200_OK)


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
