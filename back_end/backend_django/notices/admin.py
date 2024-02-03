from django.contrib import admin
from import_export import resources

from notices.models import *


# Register your models here.
class NoticesResource(resources.ModelResource):
    class Meta:
        model = Notices


class NoticesAdmin(admin.ModelAdmin):
    list_display = ('id', 'title', 'notice_type', 'user_id')
    list_filter = ('id', 'title', 'notice_type', 'user_id')
    search_fields = ('id', 'title', 'notice_type', 'user_id')
    resource_class = NoticesResource


class NoticeRecordsResource(resources.ModelResource):
    class Meta:
        model = NoticeRecords


class NoticeRecordsAdmin(admin.ModelAdmin):
    list_display = ('id', 'notice_id', 'user_id')
    list_filter = ('id', 'notice_id', 'user_id')
    search_fields = ('id', 'notice_id', 'user_id')
    resource_class = NoticeRecordsResource
