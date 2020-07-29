from django.db import models
from django.contrib.auth.models import User


class Comment(models.Model):
    commentId = models.IntegerField(default=0)
    publisher = models.ForeignKey(User, on_delete=models.CASCADE)
    time = models.DateTimeField(auto_now=True)


class Post(models.Model):
    postId = models.IntegerField(default=0)
    publisher = models.ForeignKey(User, on_delete=models.CASCADE,
                                  related_name="Publisher_Of_Post")
    time = models.DateTimeField(auto_now=True)
    markedUser = models.ManyToManyField(
        User, related_name="User_Who_Marked_Post")
    content = models.BinaryField()
    comments = models.ForeignKey(Comment, on_delete=models.CASCADE)
