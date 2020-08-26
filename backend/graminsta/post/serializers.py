"""
Serializers for post and comment
"""
from django.contrib.auth import get_user_model
from rest_framework import serializers
from .models import Post, Comment, FollowRelationship


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


class FollowSerializer(serializers.ModelSerializer):
    """
    Serializer that serializes Following people and relationship id
    """
    first_name = serializers.CharField(source='to_user.first_name')
    last_name = serializers.CharField(source='to_user.last_name')

    class Meta:
        """
        Meta Information
        """
        model = FollowRelationship
        fields = ['id', 'first_name', 'last_name', ]


class UserSerializer(serializers.ModelSerializer):
    """
    Serializer that serializes user object for follow/unfollow
    """
    is_following = serializers.SerializerMethodField()

    def get_is_following(self, obj):
        """
        Parameters
        ------------
        obj: the user object which will be serialized
        """
        relationship = FollowRelationship.objects. \
            filter(from_user=self.context.get('request_user'),
                   to_user=obj)
        return relationship.exists()

    class Meta:
        """
        Meta Information
        """
        model = get_user_model()
        fields = ['id', 'first_name', 'last_name', 'is_following']
