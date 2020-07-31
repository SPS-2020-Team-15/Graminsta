# -*- coding: UTF-8 -*-

"""
Register and Login.
"""
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import UserInfo
from .serializers import UserInfoSerializer


class UserInfoRecordView(APIView):
    """
    A class based view for creating and fetching UserInfo Record.
    """

    def get(self, request=None):
        """
        Get all the UserInfo records
        :return: returns a list of UserInfo records
        """
        user_infos = UserInfo.objects.all()
        serializer = UserInfoSerializer(user_infos, many=True)
        return Response(serializer.data)

    def post(self, request):
        """
        Create a student record
        :param request: Request object for catching student
        :return: returns a student record
        """
        serializer = UserInfoSerializer(data=request.data)
        if serializer.is_valid(raise_exception=ValueError):
            serializer.create(validated_data=request.data)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(
            serializer.error_messages,
            status=status.HTTP_400_BAD_REQUEST
        )
