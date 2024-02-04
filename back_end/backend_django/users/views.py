from rest_framework.response import Response
from rest_framework.generics import get_object_or_404
from users.models import *
from rest_framework.views import APIView
from users.serializers import RegisterSerializer


# Create your views here.
# users
class RegisterAPIView(APIView):
    def post(self, request):
        serializer = RegisterSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'success': True, 'message': '注册成功', 'data': {
                'user_id': serializer.data['id'],
            }})
        return Response(serializer.errors, status=400)


class LoginAPIView(APIView):
    def post(self, request):
        phone = request.data.get('phone')
        password = request.data.get('password')
        user = get_object_or_404(Users, phone=phone)
        if user.password == password:
            return Response({'success': True, 'message': '登录成功',
                             'data': {'user_id': user.id,
                                      'user_name': user.user_name,
                                      'right': user.right,
                                      }})
        return Response({'success': False, 'message': '用户名或密码错误'}, status=400)


class LogoutAPIView(APIView):
    def get(self, request):
        user = request.user
        user.auth_token.delete()
        return Response({'success': True, 'message': '退出成功'})


class GetUserInfoAPIView(APIView):
    def get(self, request):
        user_id = self.kwargs['user_id']
        user = get_object_or_404(Users, id=user_id)
        if user is None:
            return Response({'success': False, 'message': '用户不存在'}, status=400)
        return Response({'success': True, 'message': '获取成功',
                         'data': {'phone': user.phone,
                                  'avatar': user.avatar,
                                  'user_name': user.user_name,
                                  'buy_address': user.buy_address,
                                  'gender': user.gender,
                                  'pay_type': user.pay_type,
                                  'right': user.right
                                  }})


class ModifyPasswordAPIView(APIView):
    def post(self, request):
        user_id = self.kwargs['user_id']
        old_password = request.data.get('old_password')
        new_password = request.data.get('new_password')
        user = get_object_or_404(Users, id=user_id)
        if user.password == old_password:
            user.password = new_password
            user.save()
            return Response({'success': True, 'message': '修改成功'})
        return Response({'success': False, 'message': '原密码错误'}, status=400)


class ModifyUsernameAPIView(APIView):
    def post(self, request):
        user_id = self.kwargs['user_id']
        new_username = request.data.get('new_username')
        user = get_object_or_404(Users, id=user_id)
        if user is None:
            return Response({'success': False, 'message': '用户不存在'}, status=400)
        user.user_name = new_username
        user.save()
        return Response({'success': True, 'message': '修改成功'})


class ModifyAddressAPIView(APIView):
    def post(self, request):
        user_id = self.kwargs['user_id']
        new_address = request.data.get('new_address')
        user = get_object_or_404(Users, id=user_id)
        if user is None:
            return Response({'success': False, 'message': '用户不存在'}, status=400)
        user.buy_address = new_address
        user.save()
        return Response({'success': True, 'message': '修改成功'})


class UserProfileView(APIView):
    def get(self):
        users = Users.objects.all()
        return Response({'success': True, 'message': '获取成功',
                         'data': {'users': [{'user_id': user.id, 'user_phone': user.phone, 'user_name': user.user_name}
                                            for user in users]}})


class UploadAvatarAPIView(APIView):
    def post(self, request):
        user_id = self.kwargs['user_id']
        user = get_object_or_404(Users, id=user_id)
        if user is None:
            return Response({'success': False, 'message': '用户不存在'}, status=400)
        user.avatar = request.data.get('avatar')
        user.save()
        return Response({'success': True, 'message': '上传成功'})


class ModifyPayTypeAPIView(APIView):
    def post(self, request):
        user_id = self.kwargs['user_id']
        new_pay_type = request.data.get('new_pay_type')
        user = get_object_or_404(Users, id=user_id)
        if user is None:
            return Response({'success': False, 'message': '用户不存在'}, status=400)
        user.pay_type = new_pay_type
        user.save()
        return Response({'success': True, 'message': '修改成功'})


# follow
class FollowAPIView(APIView):
    def get(self, request):
        user_id = self.kwargs['user_id']
        follower = get_object_or_404(Users, id=user_id)
        if follower is None:
            return Response({'success': False, 'message': '用户不存在'}, status=400)
        user = request.user
        if user.id == user_id:
            return Response({'success': False, 'message': '不能关注自己'}, status=400)
        follow_ship = FollowShips.objects.filter(user_id=user.id, following_user_id=user_id)
        if follow_ship is None:
            FollowShips.objects.create(user_id=user.id, following_user_id=user_id)
            return Response({'success': True, 'message': '关注成功'})
        follow_ship.delete()
        return Response({'success': True, 'message': '取消关注成功'})


class FollowListAPIView(APIView):
    def get(self, request):
        user_id = self.kwargs['user_id']
        user = get_object_or_404(Users, id=user_id)
        if user is None:
            return Response({'success': False, 'message': '用户不存在'}, status=400)
        follow_ships = FollowShips.objects.filter(user_id=user_id)
        return Response({'success': True, 'message': '获取成功',
                         'data': {'followings': [{'following_user_id': follow_ship.following_user_id,
                                                  'following_user_name': Users.objects.get(
                                                      id=follow_ship.following_user_id).user_name}
                                                 for follow_ship in follow_ships]}})


class IfFollowAPIView(APIView):
    def get(self, request):
        user_id = self.kwargs['user_id']
        following_user_id = self.kwargs['following_user_id']
        follow_ship = FollowShips.objects.filter(user_id=user_id, following_user_id=following_user_id)
        if follow_ship is None:
            return Response({'success': False, 'message': '未关注'})
        return Response({'success': True, 'message': '已关注'})


# wallet
class WalletAPIView(APIView):
    def get(self, request):
        user_id = self.kwargs['user_id']
        user = get_object_or_404(Users, id=user_id)
        if user is None:
            return Response({'success': False, 'message': '用户不存在'}, status=400)
        wallet = Wallets.objects.get(user_id=user_id)
        return Response({'success': True, 'message': '获取成功',
                         'data': {'money_sum': wallet.money_sum}})


class WalletChargeAPIView(APIView):
    def post(self, request):
        user_id = self.kwargs['user_id']
        user = get_object_or_404(Users, id=user_id)
        if user is None:
            return Response({'success': False, 'message': '用户不存在'}, status=400)
        wallet = Wallets.objects.get(user_id=user_id)
        wallet.money_sum += request.data.get('charge_sum')
        wallet.save()
        return Response({'success': True, 'message': '充值成功'})
