from django.db import models
from users.models import Users


# Create your models here.
class Products(models.Model):
    id = models.AutoField(primary_key=True)
    user_id = models.ForeignKey(Users, on_delete=models.CASCADE)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    sell_address = models.CharField(max_length=100)
    store = models.IntegerField(default=0)
    state = models.BooleanField(default=True)

    class CheckState(models.TextChoices):
        CHECKING = '0', '审核中'
        PASS = '1', '已审核'

    check_state = models.CharField(max_length=1, choices=CheckState.choices, default=CheckState.CHECKING)
    score_per = models.DecimalField(max_digits=3, decimal_places=2, default=0.0, null=True, blank=True)
    product_name = models.CharField(max_length=50, null=True, blank=True)
    product_image = models.ImageField(upload_to='products/', null=True, blank=True)
    product_press = models.CharField(max_length=50, null=True, blank=True)

    class ProductType(models.TextChoices):
        BOOK = '0', '书籍'
        CLOTHES = '1', '服装'
        ELECTRONIC = '2', '电子产品'
        FOOD = '3', '食品'
        OTHER = '4', '其他'

    product_type = models.CharField(max_length=1, choices=ProductType.choices, default=ProductType.OTHER)

    class Meta:
        verbose_name = '商品详情'
        verbose_name_plural = '商品详情'

    def __str__(self):
        return self.product_name


class Comments(models.Model):
    comment_id = models.AutoField(primary_key=True)
    user_id = models.ForeignKey(Users, on_delete=models.CASCADE)
    product_id = models.ForeignKey(Products, on_delete=models.CASCADE)
    content = models.TextField()
    score = models.DecimalField(max_digits=3, decimal_places=2, default=0.0)
    create_at = models.DateTimeField(auto_now_add=True)
