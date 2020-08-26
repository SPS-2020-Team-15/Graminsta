# -*- coding: UTF-8 -*-
"""
Urls for post app.
"""

from django.urls import path
from .views import (PostRecordView,
                    FollowView,
                    TimelineView,
                    CommentView)


app_name = 'post'
urlpatterns = [
    path('', PostRecordView.as_view(), name='post'),
    path('follow/', FollowView.as_view(), name='follow'),
    path('follow/<user_id>/', FollowView.as_view(), name='following_people'),
    path('timeline/', TimelineView.as_view(), name='timeline'),
    path('comment/', CommentView.as_view(), name="add_comment"),
    path('comment/<post_id>/', CommentView.as_view(), name='comment')]
