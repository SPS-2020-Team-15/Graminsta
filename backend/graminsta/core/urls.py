# -*- coding: UTF-8 -*-

"""
Urls for core app.
"""

from django.urls import path
from core.views import UserInfoRecordView


urlpatterns = [
    path('user/', UserInfoRecordView.as_view(), name='user'),
]
