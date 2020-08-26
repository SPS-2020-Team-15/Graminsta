# -*- coding: UTF-8 -*-
"""views.py"""

import json
from django.contrib.auth import get_user_model
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from rest_framework.parsers import MultiPartParser, FormParser
from .serializers import PostSerializer, UserSerializer, FollowSerializer
from .services import (create_follow_relationship,
                       delete_follow_relationship,
                       get_following_relationships,
                       create_post,
                       get_all_post,
                       get_all_personal_post,
                       get_post_count,
                       get_fan_count,
                       get_following_count,
                       get_timeline_posts)


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
        response: json format relationship id and
            users that follows the given user
        """
        following = get_following_relationships(request.user)
        return Response(FollowSerializer(following, many=True).data)


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
        following = get_following_relationships(user)
        return Response(UserSerializer(following, many=True).data)


class PostRecordView(APIView):
    """
    A class based view for creating Post Record
    """
    parser_classes = [MultiPartParser, FormParser]

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
        publisher_id = int(request.data["publisher_id"])
        shared_mode = request.data["shared_mode"]
        description = request.data["description"]
        img = request.data["img"]

        mention_user = request.data["mention_usernames"]
        post = create_post(publisher_id, description,
                           img, mention_user, shared_mode)
        return Response(
            PostSerializer(post).data,
            status=status.HTTP_201_CREATED
        )

    def get(self, request):
        """
        Get All posts

        Returns
        ------------
        response: json format
            All posts
        """
        posts = get_all_post()
        body = ""
        for post in posts:
            body += json.dumps(PostSerializer(post).data)

        return Response(
            body,
            status=status.HTTP_201_CREATED
        )


class TimelineView(APIView):
    """
    A class based view to show timeline.
    """
    @staticmethod
    def get(request):
        """Gets the given user's timeline

        Parameters
        ----------
        request: GET request

        Returns
        -------
        response: json format Posts that should be
            displayed at the given user's timeline
        """
        posts = get_timeline_posts(request.user)
        return Response(PostSerializer(posts, many=True).data)


class PersonalGalleryView(APIView):
    """
    A class based view for viewing all personal posts, post count,
    following count and fans count
    """

    def get(self, request):
        """
        Get all personal post, post count, following count and fans count
        ----------
        response: json format
            Data contains all personal posts, post count,
            following count and fans count
        """
        posts = get_all_personal_post(request.user)
        result = PostSerializer(posts, many=True).data
        post_count = get_post_count(request.user)
        following_count = get_following_count(request.user)
        fan_count = get_fan_count(request.user)
        return Response({
            "posts": result,
            "post_count": post_count,
            "following_count": following_count,
            "fan_count": fan_count})


class UserView(APIView):
    """
    A class based view to list all the users.
    """
    @staticmethod
    def get(request):
        """Gets all the users and if they are followed by
            the request user.

        Parameters
        ----------
        request: GET request

        Returns
        -------
        response: json format users
        """
        context = {"request_user": request.user}
        users = get_user_model().objects.all()
        return Response(UserSerializer(users, many=True, context=context).data)
