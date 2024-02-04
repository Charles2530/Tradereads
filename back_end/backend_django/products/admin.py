from django.contrib import admin
from import_export import resources

from products.models import *


# Register your models here.
class ProductsResource(resources.ModelResource):
    class Meta:
        model = Products


@admin.register(Products)
class ProductsAdmin(admin.ModelAdmin):
    list_display = ('id', 'user_id', 'price', 'sell_address', 'store', 'state', 'check_state', 'score_per')
    list_filter = ('user_id', 'price', 'sell_address', 'store', 'state', 'check_state', 'score_per')
    search_fields = ('user_id', 'price', 'sell_address', 'store', 'state', 'check_state', 'score_per')
    resource_class = ProductsResource


class CommentsResource(resources.ModelResource):
    class Meta:
        model = Comments


@admin.register(Comments)
class CommentsAdmin(admin.ModelAdmin):
    list_display = ('comment_id', 'user_id', 'product_id', 'content', 'score', 'create_at')
    list_filter = ('comment_id', 'user_id', 'product_id', 'content', 'score', 'create_at')
    search_fields = ('comment_id', 'user_id', 'product_id', 'content', 'score', 'create_at')
    resource_class = CommentsResource
