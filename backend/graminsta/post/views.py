# -*- coding: UTF-8 -*-
"""views.py"""

from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from .services import (create_follow_relationship,
                       delete_follow_relationship,
                       get_people_user_follows)


class FollowView(APIView):
    """
    A class based view to manage follow relationship.
    """
    def post(self, request):
        """Creates a new follow relationship
        Parameters
        ----------
        request: json format
            Data containing from_user and to_user
        Returns
        -------
        response: json format
            Newly created follow relationship or errors
        """
        relationship = create_follow_relationship(request.data)
        return Response(relationship, status=status.HTTP_201_CREATED)


    def get(self, request, username):
        """Gets the given user's following people
        Parameters
        ----------
        request: get request
        username: str
        Returns
        -------
        response: json format
            Users that follows the given user
        """
        following = get_people_user_follows(username)
        return Response(following)
