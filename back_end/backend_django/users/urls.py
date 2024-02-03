from django.urls import path
from users.views import *

# 子路由
urlpatterns = [
    # users
    path('register/', RegisterAPIView.as_view(), name='register'),
    path('login/', LoginAPIView.as_view(), name='login'),
    path('logout/', LogoutAPIView.as_view(), name='logout'),
    path('users/<int:user_id>/', GetUserInfoAPIView.as_view(), name='get_user_info'),
    path('users/<int:user_id>/modify_password', ModifyPasswordAPIView.as_view(), name='modify_password'),
    path('users/<int:user_id>/modify_username', ModifyUsernameAPIView.as_view(), name='modify_username'),
    path('users/<int:user_id>/modify_address', ModifyAddressAPIView.as_view(), name='modify_address'),
    path('users/', UserProfileView.as_view(), name='user_profile'),
    path('users/<int:user_id>/upload_avatar/', UploadAvatarAPIView.as_view(), name='upload_avatar'),
    path('users/<int:user_id>/modify_pay_type', ModifyPayTypeAPIView.as_view(), name='modify_pay_type'),
    # follow
    path('users/<int:user_id>/follow_user/', FollowAPIView.as_view(), name='follow'),
    path('users/<int:user_id>/follow_list/', FollowListAPIView.as_view(), name='follow-list'),
    path('users/<int:user_id>/if_follow/', IfFollowAPIView.as_view(), name='if-follow'),
    # wallet
    path('wallet/', WalletAPIView.as_view(), name='wallet'),
    path('wallet_charge/', WalletChargeAPIView.as_view(), name='wallet-charge'),
]
