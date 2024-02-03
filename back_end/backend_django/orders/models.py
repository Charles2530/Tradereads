from django.db import models
from users.models import Users
from products.models import Products


# Create your models here.
class Orders(models.Model):
    id = models.AutoField(primary_key=True)
    user_id = models.ForeignKey(Users, on_delete=models.CASCADE)
    create_at = models.DateTimeField(auto_now_add=True)


class OrderItems(models.Model):
    id = models.AutoField(primary_key=True)
    product_id = models.ForeignKey(Products, on_delete=models.CASCADE)
    number = models.IntegerField(default=0)

    class SellState(models.TextChoices):
        PAYING = '0', '待付款'
        PAYED = '1', '待发货'
        SENDED = '2', '待收货'
        FINISHED = '3', '已完成'

    state = models.CharField(max_length=1, choices=SellState.choices, default=SellState.PAYING)
    order_id = models.ForeignKey(Orders, on_delete=models.CASCADE)
