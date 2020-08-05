# -*- coding: UTF-8 -*-
"""serializers.py"""

from rest_framework import serializers
from .models import FollowRelationship


class FollowSerializer(serializers.ModelSerializer):
    """
    Serializer that serializes/deserializes
    FollowRelationship object
    """
    class Meta:
        """
        Meta Information
        """
        model = FollowRelationship
        fields = (
            'from_user', 'to_user'
        )
