"""
Service functions for post module
"""

from django.contrib.auth import get_user_model
from django.shortcuts import get_object_or_404
from django.db.models import Q
from .models import Post, FollowRelationship, Comment


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


def get_people_user_follows(user):
    """
    Returns users that the given user follows.

    Parameters
    ------------
    user: The user whose following people will be returned.

    Returns
    -------
    follow_people: The QuerySet contains users that the
        given user follows.
    """
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


def get_timeline_posts(request_user):
    """
    Returns posts that should be displayed at timeline, including
    posts created by the request user and his/her following people,
    and posts which mention or mark the request user.
    """
    following_people = get_people_user_follows(request_user)
    posts = Post.objects.filter(Q(publisher__in=following_people) |
                                Q(publisher=request_user) |
                                Q(mention_user=request_user) |
                                Q(marked_user=request_user))
    return posts


def add_comment(post_id, user, comment):
    """
    Add a comment

    Parameters
    ------------
    post_id: The post_id user comment on
    user: The user who add the comment
    """
    post = Post.objects.get(pk=post_id)
    comment = Comment.objects.create(
        publisher=user,
        post=post,
        content=comment
    )
    return comment


def get_all_comments(post_id):
    """
    Get all the comments the post owns

    Parameters
    ------------
    post: The request post_id
    """
    post = Post.objects.get(pk=post_id)
    comments = Comment.objects.filter(post=post)
    return comments
