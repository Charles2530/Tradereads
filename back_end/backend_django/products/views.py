from rest_framework.views import APIView
from rest_framework.response import Response
from products.models import *
from carts.models import *
from products.serializers import ProductSerializer


# Create your views here.
# products
class ShowAllProductsAPIView(APIView):
    def post(self, request):
        products = Products.objects.all()
        return Response({
            'success': True,
            'message': '获取成功',
            'data': {
                'products': [
                    {
                        'product_id': product.id,
                        'product_name': product.product_name,
                        'product_image': product.product_image,
                        'price': product.price,
                        'product_press': product.product_press,
                        'product_type': product.product_type,
                        'seller_name': Users.objects.get(id=product.user_id).user_name,
                        'sell_address': product.sell_address,
                        'seller_id': product.user_id,
                    } for product in products
                ]
            }
        })


class AddProductAPIView(APIView):
    def post(self, request):
        serializer = ProductSerializer(data=request.data)
        if serializer.is_valid():
            product = serializer.save()
            return Response({
                'success': True,
                'message': '添加成功',
                'data': {
                    'product_id': product.id,
                    'state': product.state,
                }
            })
        return Response(serializer.errors, status=400)


class ProductDetailAPIView(APIView):
    def get(self, request):
        product_id = self.kwargs['product_id']
        product = Products.objects.get(id=product_id)
        product_state = product.store > 0
        return Response({
            'success': True,
            'message': '获取成功',
            'data': {
                'product_name': product.product_name,
                'product_image': product.product_image,
                'product_press': product.product_press,
                'price': product.price,
                'product_state': product_state,
                'seller_name': Users.objects.get(id=product.user_id).user_name,
                'seller_phone': Users.objects.get(id=product.user_id).phone,
            }
        })


class UserProductsAPIView(APIView):
    def get(self, request):
        user_id = self.kwargs['user_id']
        products = Products.objects.filter(user_id=user_id)
        return Response({
            'success': True,
            'message': '获取成功',
            'data': {
                'products': [
                    {
                        'product_id': product.id,
                        'product_name': product.product_name,
                        'product_image': product.product_image,
                        'product_store': product.store,
                        'sell_address': product.sell_address,
                        'price': product.price,
                        'check_state': product.check_state,
                    } for product in products
                ]
            }
        })


class ModifyStoreAPIView(APIView):
    def post(self, request):
        product_id = self.kwargs['product_id']
        product = Products.objects.get(id=product_id)
        if product is None:
            return Response({'success': False, 'message': '商品不存在'}, status=400)
        product.store = request.data.get('new_store')
        product.save()
        return Response({'success': True, 'message': '修改成功'})


class ModifyPriceAPIView(APIView):
    def post(self, request):
        product_id = self.kwargs['product_id']
        product = Products.objects.get(id=product_id)
        if product is None:
            return Response({'success': False, 'message': '商品不存在'}, status=400)
        product.price = request.data.get('new_price')
        product.save()
        return Response({'success': True, 'message': '修改成功'})


class ModifySellAddressAPIView(APIView):
    def post(self, request):
        product_id = self.kwargs['product_id']
        product = Products.objects.get(id=product_id)
        if product is None:
            return Response({'success': False, 'message': '商品不存在'}, status=400)
        product.sell_address = request.data.get('new_address')
        product.save()
        return Response({'success': True, 'message': '修改成功'})


class AddProductToCartAPIView(APIView):
    def post(self, request):
        product_id = self.kwargs['product_id']
        product = Products.objects.get(id=product_id)
        count = request.data.get('count')
        if product is None:
            return Response({'success': False, 'message': '商品不存在'}, status=400)
        if count > product.store:
            return Response({'success': False, 'message': '库存不足'}, status=400)
        Carts.objects.create(
            user_id=request.user.id,
            product_id=product_id,
            count=count
        )
        product.store -= count
        return Response({'success': True, 'message': '添加成功'})


class RemoveProductAPIView(APIView):
    def delete(self, request):
        product_id = self.kwargs['product_id']
        product = Products.objects.get(id=product_id)
        if product is None:
            return Response({'success': False, 'message': '商品不存在'}, status=400)
        product.delete()
        return Response({'success': True, 'message': '删除成功'})


class BuyProductAPIView(APIView):
    def post(self, request):
        product_id = self.kwargs['product_id']
        product = Products.objects.get(id=product_id)
        count = request.data.get('count')
        if product is None:
            return Response({'success': False, 'message': '商品不存在'}, status=400)
        if count > product.store:
            return Response({'success': False, 'message': '库存不足'}, status=400)
        product.store -= count
        product.save()
        return Response({'success': True, 'message': '购买成功'})


class ModifyProductNameAPIView(APIView):
    def post(self, request):
        product_id = self.kwargs['product_id']
        product = Products.objects.get(id=product_id)
        if product is None:
            return Response({'success': False, 'message': '商品不存在'}, status=400)
        product.product_name = request.data.get('new_name')
        product.save()
        return Response({'success': True, 'message': '修改成功'})


class UploadImageAPIView(APIView):
    def post(self, request):
        product_id = request.data.get('product_id')
        product = Products.objects.get(id=product_id)
        if product is None:
            return Response({'success': False, 'message': '商品不存在'}, status=400)
        product.product_image = request.data.get('image')
        product.save()
        return Response({'success': True, 'message': '上传成功'})


# check
class CheckProductAPIView(APIView):
    def post(self, request):
        products = Products.objects.filter(check_state=Products.CheckState.CHECKING)
        return Response({
            'success': True,
            'message': '获取成功',
            'data': {
                'products': [
                    {
                        'product_id': product.id,
                        'product_name': product.product_name,
                        'product_image': product.product_image,
                        'price': product.price,
                        'product_press': product.product_press,
                        'product_type': product.product_type,
                        'seller_name': Users.objects.get(id=product.user_id).user_name,
                        'sell_address': product.sell_address,
                        'seller_id': product.user_id,
                        'check_state': product.check_state,
                    } for product in products
                ]
            }
        })


class ModifyProductStateAPIView(APIView):
    def post(self, request):
        product_id = self.kwargs['product_id']
        product = Products.objects.get(id=product_id)
        if product is None:
            return Response({'success': False, 'message': '商品不存在'}, status=400)
        product.check_state = request.data.get('check_result')
        product.save()
        return Response({'success': True, 'message': '审核完成'})


# comments
class AddCommentAPIView(APIView):
    def post(self, request):
        product_id = self.kwargs['product_id']
        product = Products.objects.get(id=product_id)
        if product is None:
            return Response({'success': False, 'message': '商品不存在'}, status=400)
        comment = Comments.objects.create(
            user_id=request.user.id,
            product_id=product_id,
            content=request.data.get('content'),
            score=request.data.get('score')
        )
        return Response({'success': True,
                         'message': '评论成功',
                         'data': {
                             'comment_id': comment.comment_id,
                             'date': comment.create_at,
                         }})


class DeleteCommentAPIView(APIView):
    def delete(self, request):
        comment_id = self.kwargs['comment_id']
        comment = Comments.objects.get(comment_id=comment_id)
        if comment is None:
            return Response({'success': False, 'message': '评论不存在'}, status=400)
        if request.user.rights != Users.UserType.ADMIN and request.user.id != comment.user_id:
            return Response({'success': False, 'message': '权限不足'}, status=400)
        comment.delete()
        return Response({'success': True, 'message': '删除成功'})


class ShowCommentsAPIView(APIView):
    def get(self, request):
        product_id = self.kwargs['product_id']
        comments = Comments.objects.filter(product_id=product_id)
        return Response({
            'success': True,
            'message': '获取成功',
            'data': {
                'comments': [
                    {
                        'comment_id': comment.comment_id,
                        'user_name': Users.objects.get(id=comment.user_id).user_name,
                        'content': comment.content,
                        'score': comment.score,
                        'date': comment.create_at,
                    } for comment in comments
                ]
            }
        })


# statistics
class ProductTypeNumberAPIView(APIView):
    def get(self, request):
        products = Products.objects.all()
        statistics = []
        for type in Products.ProductType:
            count = products.filter(product_type=type).count()
            statistics.append({
                'value': count,
                'name': type
            })
        return Response({
            'success': True,
            'message': '获取成功',
            'data': {
                'statistics': statistics
            }
        })


class UserSellRankAPIView(APIView):
    def get(self, request):
        users = Users.objects.all()
        statistics = []
        sorted_users = users.sort(key=lambda user: Products.objects.filter(user_id=user.id).count(), reverse=True)
        for user in sorted_users:
            count = Products.objects.filter(user_id=user.id).count()
            statistics.append({
                'value': count,
                'user_name': user.user_name,
                'user_id': user.id,
                'user_avatar': user.avatar,
            })
        return Response({
            'success': True,
            'message': '获取成功',
            'data': {
                'statistics': statistics
            }
        })
