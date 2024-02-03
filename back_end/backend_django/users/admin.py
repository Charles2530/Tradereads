from django.contrib import admin
from import_export import resources

from users.models import *


# Register your models here.
class UsersResource(resources.ModelResource):
    class Meta:
        model = Users


@admin.register(Users)
class UsersAdmin(admin.ModelAdmin):
    list_display = ('id', 'phone', 'right')
    list_filter = ('id', 'phone', 'right')
    search_fields = ('id', 'phone', 'right')
    resource_class = UsersResource


class UserDetailResource(resources.ModelResource):
    class Meta:
        model = UserDetail


@admin.register(UserDetail)
class UserDetailAdmin(admin.ModelAdmin):
    list_display = ('user_id', 'password', 'user_name', 'buy_address',
                    'gender', 'pay_type', 'avatar')
    list_filter = ('user_id', 'password', 'user_name', 'buy_address',
                   'gender', 'pay_type', 'avatar')
    search_fields = ('user_id', 'password', 'user_name', 'buy_address',
                     'gender', 'pay_type', 'avatar')
    resource_class = UserDetailResource


class WalletsResource(resources.ModelResource):
    class Meta:
        model = Wallets


@admin.register(Wallets)
class WalletsAdmin(admin.ModelAdmin):
    list_display = ('user_id', 'money_sum')
    list_filter = ('user_id', 'money_sum')
    search_fields = ('user_id', 'money_sum')
    resource_class = WalletsResource


class FollowShipsResource(resources.ModelResource):
    class Meta:
        model = FollowShips


@admin.register(FollowShips)
class FollowShipsAdmin(admin.ModelAdmin):
    list_display = ('user_id', 'following_user_id')
    list_filter = ('user_id', 'following_user_id')
    search_fields = ('user_id', 'following_user_id')
    resource_class = FollowShipsResource
