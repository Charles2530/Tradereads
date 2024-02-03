from django.urls import path
from users.views import *

# 子路由
urlpatterns = [
    # users
    path('register/', RegisterAPIView, name='register'),
    path('login/', LoginAPIView, name='login'),
    path('logout/', LogoutAPIView, name='logout'),
    path('users/<int:user_id>/', GetUserInfoAPIView, name='get_user_info'),
    path('users/<int:user_id>/modify_password', ModifyPasswordAPIView, name='modify_password'),
    path('users/<int:user_id>/modify_username', ModifyUsernameAPIView, name='modify_username'),
    path('users/<int:user_id>/modify_address', ModifyAddressAPIView, name='modify_address'),
    path('users/', UserProfileView, name='user_profile'),
    path('users/<int:user_id>/upload_avatar/', UploadAvatarAPIView, name='upload_avatar'),
    path('users/<int:user_id>/modify_pay_type', ModifyPayTypeAPIView, name='modify_pay_type'),
    # follow
    path('users/<int:user_id>/follow_user/', FollowAPIView, name='follow'),
    path('users/<int:user_id>/follow_list/', FollowListAPIView, name='follow-list'),
    path('users/<int:user_id>/if_follow/', IfFollowAPIView, name='if-follow'),
    # wallet
    path('wallet/', WalletAPIView, name='wallet'),
    path('wallet_charge/', WalletChargeAPIView, name='wallet-charge'),
]
