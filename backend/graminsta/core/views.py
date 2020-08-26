# -*- coding: UTF-8 -*-

"""
Register and Login.
"""
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .services import create_userinfo, create_authentication_token, \
    get_user_model
from .serializers import UserSerializer, UserInfoSerializer


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
        """Get user's displayed name based on request's requirements

        Parameters
        --------------
        request: json format
            Data containing request information, or None

        Returns
        --------------
        response: json format
            displayed name of all users that satisfy the requirements
        """
        all_users = get_all_users()
        all_users_name = []
        separator = ","
        for user in all_users:
            all_users_name.append(user.first_name + " " + user.last_name)
        return Response(
            separator.join(all_users_name),
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
