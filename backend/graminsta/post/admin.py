# -*- coding: UTF-8 -*-
"""admin.py"""

from django.contrib import admin
from .models import FollowRelationship
from .models import Post

admin.site.register(FollowRelationship)
admin.site.register(Post)
