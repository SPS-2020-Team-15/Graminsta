from rest_framework import serializers
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
    class Meta:
        """
        Meta Information
        """
        model = Comment
        fields = '__all__'