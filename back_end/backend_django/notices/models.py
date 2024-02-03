from django.db import models
from users.models import Users


# Create your models here.
class Notices(models.Model):
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=50)

    class NoticeType(models.TextChoices):
        SYSTEM = '0', '系统通知'
        USER = '2', '关注商家上新'
        PAY = '3', '支付通知'

    notice_type = models.CharField(max_length=1, choices=NoticeType.choices, default=NoticeType.SYSTEM)
    user_id = models.ForeignKey(Users, on_delete=models.CASCADE)


class NoticeRecords(models.Model):
    id = models.AutoField(primary_key=True)
    notice_id = models.ForeignKey(Notices, on_delete=models.CASCADE)
    user_id = models.ForeignKey(Users, on_delete=models.CASCADE)
