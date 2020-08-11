"""
Urls for post app.
"""

from django.urls import path
from .views import PostRecordView


app_name = 'post'
urlpatterns = [
    path('create-post/', PostRecordView.as_view(), name='post'),
]
