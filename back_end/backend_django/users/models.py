from django.db import models


# Create your models here.
class Users(models.Model):
    id = models.AutoField(primary_key=True)
    phone = models.CharField(max_length=11)

    class UserType(models.TextChoices):
        ORDINARY = '0', '普通用户'
        ADMIN = '1', '管理员'

    right = models.CharField(max_length=1, choices=UserType.choices, default=UserType.ORDINARY)
    password = models.CharField(max_length=20, null=True, blank=True)
    user_name = models.CharField(max_length=50, null=True, blank=True)
    buy_address = models.CharField(max_length=100, default='')

    class Gender(models.TextChoices):
        MAN = '0', '男'
        WOM = '1', '女'

    gender = models.CharField(max_length=1, choices=Gender.choices, default=Gender.MAN)

    class PayType(models.TextChoices):
        ALIPAY = '0', '支付宝'
        WECHAT = '1', '微信'
        BANK = '2', '银行卡'

    pay_type = models.CharField(max_length=1, choices=PayType.choices, default=PayType.ALIPAY)
    avatar = models.ImageField(upload_to='avatars/', null=True, blank=True, default='avatars/default.jpg')

    class Meta:
        verbose_name = '用户'
        verbose_name_plural = '用户'

    def __str__(self):
        return self.phone


class Wallets(models.Model):
    user_id = models.ForeignKey(Users, on_delete=models.CASCADE)
    money_sum = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        verbose_name = '钱包'
        verbose_name_plural = '钱包'

    def __str__(self):
        return self.user_id


class FollowShips(models.Model):
    user_id = models.ForeignKey(Users, on_delete=models.CASCADE, related_name='user_id')
    following_user_id = models.ForeignKey(Users, on_delete=models.CASCADE, related_name='following_user_id')

    class Meta:
        verbose_name = '关注'
        verbose_name_plural = '关注'

    def __str__(self):
        return self.user_id
