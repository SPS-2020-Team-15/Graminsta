# -*- coding: UTF-8 -*-
"""
Urls for post app.
"""

from django.urls import path
from .views import PostRecordView, FollowView, PersonalGalleryView


app_name = 'post'
urlpatterns = [
    path('', PostRecordView.as_view(), name='post'),
    path('follow/', FollowView.as_view(), name='follow'),
    path('follow/<user_id>/', FollowView.as_view(), name='following_people'),
    path('personal/', PersonalGalleryView.as_view(), name='personal_gallery')]
