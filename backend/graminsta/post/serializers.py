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
    first_name = serializers.CharField(source='to_user.first_name')
    last_name = serializers.CharField(source='to_user.last_name')

    class Meta:
        model = FollowRelationship
        fields = ['id', 'first_name', 'last_name', ]


class UserSerializer(serializers.ModelSerializer):
    is_following = serializers.SerializerMethodField()

    def get_is_following(self, obj):
        relationship = FollowRelationship.objects. \
            filter(from_user=self.context.get('request_user'),
                   to_user=obj)
        return relationship.exists()

    class Meta:
        model = get_user_model()
        fields = ['id', 'first_name', 'last_name', 'is_following']
