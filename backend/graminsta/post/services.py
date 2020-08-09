"""
Service functions for post module
"""

from .serializers import PostSerializer
from .models import Post
import datetime


def create_post(publisher_id, description, img):
    """Create or update a Post in datebase.

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
    post: json format
        a successfully created post
    """
    # Get publisher object with publisher_name
    publisher = get_user_model().objects.get(pk=publisher_id)
    # Get the default image
    post = Post.objects.create(
        publisher=publisher,
        description=description,
        img=img,
        created_at=datetime.datetime.now()
    )
    post.save()
    return post
