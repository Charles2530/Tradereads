from rest_framework.views import APIView
from rest_framework.response import Response
from products.models import *
from users.models import *
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
    pass


class ModifyPriceAPIView(APIView):
    pass


class ModifySellAddressAPIView(APIView):
    pass


class AddProductToCartAPIView(APIView):
    pass


class RemoveProductAPIView(APIView):
    pass


class BuyProductAPIView(APIView):
    pass


class ModifyProductNameAPIView(APIView):
    pass


class UploadImageAPIView(APIView):
    pass


# check
class CheckProductAPIView(APIView):
    pass


class ModifyProductStateAPIView(APIView):
    pass


# comments
class AddCommentAPIView(APIView):
    pass


class DeleteCommentAPIView(APIView):
    pass


class ShowCommentsAPIView(APIView):
    pass


# statistics
class ProductTypeNumberAPIView(APIView):
    pass


class UserSellRankAPIView(APIView):
    pass
