from django.db import models
from users.models import Users
from products.models import Products


# Create your models here.
class Carts(models.Model):
    user_id = models.ForeignKey(Users, on_delete=models.CASCADE)
    product_id = models.ForeignKey(Products, on_delete=models.CASCADE)
    number = models.IntegerField(default=0)
    addTime = models.DateTimeField(auto_now_add=True)
