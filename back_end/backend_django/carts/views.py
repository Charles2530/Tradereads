from rest_framework.views import APIView
from rest_framework.response import Response
from .models import Carts
from products.models import Products
from users.models import Users
from orders.models import Orders, OrderItems


# Create your views here.
class ShowCartAPIView(APIView):
    def get(self, request):
        user = request.user
        cart = Carts.objects.filter(user_id=user.id)
        return Response({
            'success': True,
            'message': '获取购物车成功',
            'data': {
                'total_price': sum([item.product_id.price * item.number for item in cart]),
                'products': [
                    {
                        'product_id': item.product_id,
                        'product_name': Products.objects.get(id=item.product_id).name,
                        'seller_name': Users.objects.get(
                            id=Products.objects.get(id=item.product_id).seller_id).user_name,
                        'product_number': item.number,
                    }
                    for item in cart
                ]
            }})


class AddCartAPIView(APIView):
    def get(self, request):
        user = request.user
        carts = Carts.objects.filter(user_id=user.id)
        order = Orders.objects.create(
            user_id=user.id,
        )
        order_items = []
        for cart in carts:
            order_item = OrderItems.objects.create(
                product_id=cart.product_id,
                number=cart.number,
                order_id=order.id,
                state=OrderItems.SellState.PAYING
            )
            order_items.append(order_item)
            cart.delete()
        return Response({
            'success': True,
            'message': '下单成功'
        })


class AddCartToOrderAPIView(APIView):
    def post(self, request):
        user = request.user
        carts = request.data.get('choose_carts')
        order = Orders.objects.create(
            user_id=user.id,
        )
        order_items = []
        for cart in carts:
            order_item = OrderItems.objects.create(
                product_id=cart.product_id,
                number=cart.number,
                order_id=order.id,
                state=OrderItems.SellState.PAYING
            )
            order_items.append(order_item)
            cart.delete()
        return Response({
            'success': True,
            'message': '下单成功'
        })


class RemoveFromCartAPIView(APIView):
    def delete(self, request):
        product_id = request.kwargs.get('product_id')
        user = request.user
        cart = Carts.objects.filter(user_id=user.id, product_id=product_id)
        cart.delete()
        product = Products.objects.get(id=product_id)
        product.store += 1
        return Response({
            'success': True,
            'message': '成功将商品从购物车移除'
        })
