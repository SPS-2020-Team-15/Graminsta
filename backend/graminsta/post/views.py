# -*- coding: UTF-8 -*-
"""views.py"""

from django.contrib.auth import get_user_model
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from core.serializers import UserSerializer
from .services import (create_follow_relationship,
                       delete_follow_relationship,
                       get_people_user_follows)


class FollowView(APIView):
    """
    A class based view to manage follow relationship.
    """
    @staticmethod
    def post(request):
        """Creates a new follow relationship

        Parameters
        ----------
        request: json format
            Data containing from_user and to_user
        """
        request_user = request.user
        target_user_id = request.data.get('target_user')
        target_user = get_user_model().objects.get(pk=target_user_id)
        create_follow_relationship(request_user, target_user)
        return Response(status=status.HTTP_201_CREATED)

    @staticmethod
    def delete(request):
        """Deletes an existing follow relationship

        Parameters
        ----------
        request: json format
            Data containing from_user and to_user
        """
        request_user = request.user
        target_user_id = request.data.get('target_user')
        target_user = get_user_model().objects.get(pk=target_user_id)
        delete_follow_relationship(request_user, target_user)
        return Response(status=status.HTTP_204_NO_CONTENT)

    @staticmethod
    def get(request, username):
        """Gets the given user's following people

        Parameters
        ----------
        request: GET request
        username: str

        Returns
        -------
        response: json format
            Users that follows the given user
        """
        following_people = get_people_user_follows(username)
        return Response(UserSerializer(following_people, many=True).data)
