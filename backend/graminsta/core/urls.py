# -*- coding: UTF-8 -*-

"""
Urls for core app.
"""

from django.urls import path
from core.views import UserInfoRecordView, UserLoginView, UserInfoView

app_name = 'core'
urlpatterns = [
    path('user/', UserInfoRecordView.as_view(), name='user'),
    path('login/', UserLoginView.as_view(), name='login'),
    path('info/', UserInfoView.as_view(), name='info')]
