# -*- coding: UTF-8 -*-
"""
Urls for post app.
"""

from django.urls import path
from .views import PostRecordView, FollowView


app_name = 'post'
urlpatterns = [
    path('', PostRecordView.as_view(), name='post'),
    path('follow/', FollowView.as_view(), name='follow'),
    path('follow/<username>/', FollowView.as_view(), name='following_people')]
