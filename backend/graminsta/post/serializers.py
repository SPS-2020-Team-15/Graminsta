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
    publisher_username = serializers.CharField(source='publisher.username')
    marked_username = serializers.SerializerMethodField()
    mention_username = serializers.SerializerMethodField()
    time_stamp = serializers.SerializerMethodField()

    @classmethod
    def get_marked_username(cls, obj):
        """
        Change the id to username in marked_user.
        """
        return [publisher.username for publisher in obj.marked_user.all()]

    @classmethod
    def get_mention_username(cls, obj):
        """
        Change the id to username in mention_user.
        """
        return [publisher.username for publisher in obj.mention_user.all()]

    @classmethod
    def get_time_stamp(cls, obj):
        """
        Change the time format.
        """
        return obj.created_at.strftime("%m-%d %H:%M")

    class Meta:
        """
        Meta Information
        """
        model = Post
        fields = ["id",
                  "publisher",
                  "publisher_username",
                  "description",
                  "img",
                  "time_stamp",
                  "marked_username",
                  "mention_username"]


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
