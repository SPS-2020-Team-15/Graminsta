from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import PostSerializer
from .services import create_post
from rest_framework.parsers import MultiPartParser
from django.contrib.auth import models as auth_models


class PostRecordView(APIView):
    """
    A class based view for creating Post Record
    """
    parser_classes = [MultiPartParser]

    def post(self, request):
        """
        Create a Post record

        Parameters
        ----------
        request: json format
            Data containing publisher_id, description and image binary data

        Returns
        ----------
        response: json format
            Newly created post
        """

        # _ is not allowed in header key
        publisher_id = int(request.META.get("HTTP_PUBLISHERID"))
        description = request.data["description"]
        img = request.data["img"]
        post = create_post(publisher_id, description, img)
        return Response(
            PostSerializer(post).data,
            status=status.HTTP_201_CREATED
        )
