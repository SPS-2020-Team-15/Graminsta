"""
Service functions for post module
"""

import datetime
from django.contrib.auth import get_user_model
from .models import Post


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
        created_at=datetime.datetime.now(),
    )

    user_ids = mention_user_ids.split(",")
    users = get_user_model().objects.filter(pk__in=user_ids)
    post.mention_user.set(users)
    post.save()
    return post
