# -*- coding: UTF-8 -*-
"""
Urls for post app.
"""

from django.urls import path
from .views import (PostRecordView, FollowView, UnfollowView,
                    FollowingView, TimelineView)

app_name = 'post'
urlpatterns = [
    path('', PostRecordView.as_view(), name='post'),
    path('follow/', FollowView.as_view(), name='follow'),
    path('unfollow/', UnfollowView.as_view(), name='unfollow'),
    path('following/<user_id>/', FollowingView.as_view(),
         name='following_people'),
    path('timeline/', TimelineView.as_view(), name='timeline')]
