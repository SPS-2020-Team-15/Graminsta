# -*- coding: UTF-8 -*-
"""
Urls for post app.
"""

from django.urls import path
from .views import (PostRecordView, FollowView, FollowerView, UnfollowView,
                    FollowingView, TimelineView, UserView,
                    CommentView, PersonalGalleryView)

app_name = 'post'
urlpatterns = [
    path('', PostRecordView.as_view(), name='post'),
    path('users/', UserView.as_view(), name='users'),
    path('follow/', FollowView.as_view(), name='follow'),
    path('follower/', FollowerView.as_view(), name='follower'),
    path('unfollow/', UnfollowView.as_view(), name='unfollow'),
    path('following/<user_id>/', FollowingView.as_view(),
         name='following_people'),
    path('timeline/', TimelineView.as_view(), name='timeline'),
    path('comment/', CommentView.as_view(), name="add_comment"),
    path('comment/<post_id>/', CommentView.as_view(), name='comment'),
    path('personal/', PersonalGalleryView.as_view(), name='personal_gallery')
]
