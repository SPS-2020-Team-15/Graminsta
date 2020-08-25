"""
Serializers for post and comment
"""


from rest_framework import serializers
from .models import Post, Comment


class PostSerializer(serializers.ModelSerializer):
    """
    Serializer that serializes Post object
    """
    publisher_username = \
        serializers.SerializerMethodField('get_publisher_username')
    marked_username = \
        serializers.SerializerMethodField('get_marked_username')
    mention_username = \
        serializers.SerializerMethodField('get_mention_username')
    time_stamp = serializers.SerializerMethodField('get_time_stamp')

    class Meta:
        """
        Meta Information
        """
        model = Post
        fields = ["publisher",
                  "publisher_username",
                  "description",
                  "img",
                  "time_stamp",
                  "marked_username",
                  "mention_username"]

    def get_publisher_username(self, obj):
        return obj.publisher.username

    def get_marked_username(self, obj):
        return [publisher.username for publisher in obj.marked_user.all()]

    def get_mention_username(self, obj):
        return [publisher.username for publisher in obj.mention_user.all()]

    def get_time_stamp(self, obj):
        return obj.created_at.strftime("%m-%d %H:%M")


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
