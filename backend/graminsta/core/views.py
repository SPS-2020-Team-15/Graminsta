# -*- coding: UTF-8 -*-

"""
Register and Login.
"""
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .services import get_all_user_infos
from .services import create_userinfo
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
            Data containing request informationm, or None.

        Returns
        -------
        response: json format
            Newly created user_info
        """
        return_type = create_userinfo(request.data)
        if 'error' in return_type.keys():
            return Response(
                return_type['error'],
                status=status.HTTP_400_BAD_REQUEST
            )
        return Response(
            UserInfoSerializer(return_type['user_info']).data,
            status=status.HTTP_201_CREATED
        )
