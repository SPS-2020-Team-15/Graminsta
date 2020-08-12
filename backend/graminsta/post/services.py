"""
Service functions for post module
"""

import datetime
from django.contrib.auth import get_user_model
from django.shortcuts import get_object_or_404
from .models import Post, FollowRelationship


def create_post(publisher_id, description, img, mention_user_ids):
    """Create a Post in datebase.

    Parameters
    ----------
    publisher_name: string
        name of the publisher
    description: string
        description of the post
    img:  binary data
        image content of the post

    Returns
    -------
    post: a successfully created post object
    """
    # Get publisher object with publisher_name
    publisher = get_user_model().objects.get(pk=publisher_id)
    # Get the default image
    post = Post.objects.create(
        publisher=publisher,
        description=description,
        img=img,
    )

    user_ids = mention_user_ids.split(",")
    users = get_user_model().objects.filter(pk__in=user_ids)
    post.mention_user.set(users)
    post.save()
    return post


def get_people_user_follows(username):
    """
    Returns users that the given user follows.

    Parameters
    ------------
    username: str

    Returns
    -------
    follow_people: The QuerySet contains users that the
        given user follows.
    """
    user = get_user_model().objects.get(username=username)
    ids = FollowRelationship.objects.filter(from_user=user) \
        .values_list('to_user_id', flat=True)
    following_people = get_user_model().objects.filter(id__in=ids)
    return following_people


def create_follow_relationship(request_user, target_user):
    """
    Creates a new follow relationship.

    Parameters
    ------------
    request_user: The user who triggered this action.
    target_user: The user who will be followed by the request_user.

    Returns
    -------
    follow_relationship: The new follow relationship object.
    """
    follow_relationship = FollowRelationship.objects.create(
        from_user=request_user,
        to_user=target_user)
    return follow_relationship


def delete_follow_relationship(request_user, target_user):
    """
    Deletes an existing follow relationship.

    Parameters
    ------------
    request_user: The user who triggered this action.
    target_user: The user who will be unfollowed by the request_user.
    """
    relationship = get_object_or_404(FollowRelationship,
                                     from_user=request_user,
                                     to_user=target_user)
    relationship.delete()
