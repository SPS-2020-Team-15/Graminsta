# -*- coding: UTF-8 -*-
"""views.py"""

from django.contrib.auth import get_user_model
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from rest_framework.parsers import MultiPartParser
from core.serializers import UserSerializer
from .serializers import PostSerializer
from .services import (create_follow_relationship,
                       delete_follow_relationship,
                       get_people_user_follows,
                       create_post)


class FollowView(APIView):
    """
    A class based view to create and look up follow relationship.
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
        target_user_id = int(request.data.get('target_user'))
        target_user = get_user_model().objects.get(pk=target_user_id)
        create_follow_relationship(request_user, target_user)
        return Response(status=status.HTTP_201_CREATED)

    @staticmethod
    def get(request):
        """Gets the request user's following people

        Parameters
        ----------
        request: GET request

        Returns
        -------
        response: json format
            Users that follows the given user
        """
        following_people = get_people_user_follows(request.user)
        return Response(UserSerializer(following_people, many=True).data)


class UnfollowView(APIView):
    """
    A class based view to delete follow relationship.
    """
    @staticmethod
    def post(request):
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


class FollowingView(APIView):
    """
    A class based view to get any specific user's following people.
    """
    @staticmethod
    def get(request, user_id):
        """Gets the given user's following people

        Parameters
        ----------
        request: GET request
        user_id: int

        Returns
        -------
        response: json format
            Users that follows the given user
        """
        user = get_user_model().objects.get(pk=user_id)
        following_people = get_people_user_follows(user)
        return Response(UserSerializer(following_people, many=True).data)


class PostRecordView(APIView):
    """
    A class based view for creating Post Record
    """
    parser_classes = [MultiPartParser]

    def post(self, request):
        """
        Create a Post record

        Parameters
        ----------
        request: json format
            Data containing publisher_id, description and image binary data

        Returns
        ----------
        response: json format
            Newly created post
        """

        # _ is not allowed in header key
        # TODO: get user from request
        publisher_id = int(request.META.get("HTTP_PUBLISHERID"))
        description = request.data["description"]
        img = request.data["img"]
        mention_user_ids = request.data["mention_user_ids"]
        post = create_post(publisher_id, description, img, mention_user_ids)
        return Response(
            PostSerializer(post).data,
            status=status.HTTP_201_CREATED
        )
