# -*- coding: UTF-8 -*-
"""admin.py"""

from django.contrib import admin
from .models import (FollowRelationship,
                     Post,
                     Comment)


admin.site.register(FollowRelationship)
admin.site.register(Post)
admin.site.register(Comment)
