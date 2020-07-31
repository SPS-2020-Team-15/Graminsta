# -*- coding: UTF-8 -*-

"""
Urls for  core app.
"""

from django.urls import path
from .views import UserInfoRecordView


app_name = 'core'
urlpatterns = [
    path('user/', UserInfoRecordView.as_view(), name='user'),
]
