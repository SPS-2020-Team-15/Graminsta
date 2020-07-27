from django.db import models

# Create your models here.
class User(models.Model):
    user_name = models.CharField(max_length=20)
    password = models.CharField(max_length=20)
    email = models.EmailField()

    def __str__(self):
        return str(self.id)
