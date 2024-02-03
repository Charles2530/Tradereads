from django.shortcuts import render
from django.http import HttpResponse
from users.models import *
from rest_framework.views import APIView


# Create your views here.
# users
class RegisterAPIView(APIView):
    def post(self, request):
        phone = request.data.get('phone')
        user_name = request.data.get('user_name')
        gender = request.data.get('gender')
        password = request.data.get('password')
        return HttpResponse('ok')

    pass


class LoginAPIView(APIView):
    pass


class LogoutAPIView(APIView):
    pass


class GetUserInfoAPIView(APIView):
    pass


class ModifyPasswordAPIView(APIView):
    pass


class ModifyUsernameAPIView(APIView):
    pass


class ModifyAddressAPIView(APIView):
    pass


class UserProfileView(APIView):
    pass


class UploadAvatarAPIView(APIView):
    pass


class ModifyPayTypeAPIView(APIView):
    pass


# follow
class FollowAPIView(APIView):
    pass


class FollowListAPIView(APIView):
    pass


class IfFollowAPIView(APIView):
    pass


# wallet
class WalletAPIView(APIView):
    pass


class WalletChargeAPIView(APIView):
    pass
