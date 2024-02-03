from django.contrib import admin
from import_export import resources
from carts.models import Carts


# Register your models here.
class CartsResource(resources.ModelResource):
    class Meta:
        model = Carts


@admin.register(Carts)
class CartsAdmin(admin.ModelAdmin):
    list_display = ('user_id', 'product_id', 'number', 'addTime')
    list_filter = ('user_id', 'product_id', 'number', 'addTime')
    search_fields = ('user_id', 'product_id', 'number', 'addTime')
    resource_class = CartsResource
