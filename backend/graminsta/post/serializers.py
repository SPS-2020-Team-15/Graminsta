"""
Serializers for post and comment
"""


from rest_framework import serializers
from core.serializers import UserSerializer
from .models import Post, Comment


class PostSerializer(serializers.ModelSerializer):
    """
    Serializer that serializes Post object
    """
    class Meta:
        """
        Meta Information
        """
        model = Post
        fields = '__all__'


class CommentSerializer(serializers.ModelSerializer):
    """
    Serializer that serializes Comment object
    """
    publisher = UserSerializer(required=True)

    class Meta:
        """
        Meta Information
        """
        model = Comment
        fields = (
            'publisher',
            'content',
            'created_at',
            'post'
        )
