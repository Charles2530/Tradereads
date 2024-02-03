from django.contrib import admin
from import_export import resources

from orders.models import *


# Register your models here.
class OrdersResource(resources.ModelResource):
    class Meta:
        model = Orders


class OrdersAdmin(admin.ModelAdmin):
    list_display = ('id', 'user_id', 'create_at')
    list_filter = ('id', 'user_id', 'create_at')
    search_fields = ('id', 'user_id', 'create_at')
    resource_class = OrdersResource


class OrderItemsResource(resources.ModelResource):
    class Meta:
        model = OrderItems


class OrderItemsAdmin(admin.ModelAdmin):
    list_display = ('id', 'product_id', 'number', 'state', 'order_id')
    list_filter = ('id', 'product_id', 'number', 'state', 'order_id')
    search_fields = ('id', 'product_id', 'number', 'state', 'order_id')
    resource_class = OrderItemsResource
