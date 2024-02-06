from rest_framework.views import APIView
from rest_framework.response import Response
from orders.models import *
from users.models import Users


# Create your views here.
class ShowAllOrdersAPIView(APIView):
    def get(self, request):
        user_id = request.user.id
        all_orders = Orders.objects.filter(user_id=user_id)
        orders = []
        for order in all_orders:
            order_id = order.id
            all_items = OrderItems.objects.filter(order_id=order_id)
            items = []
            for item in all_items:
                product = Products.objects.get(id=item.product_id)
                items.append({
                    'product_image': product.image,
                    'product_name': product.name,
                    'sell_address': product.sell_address,
                    'buy_num': item.number,
                    'product_price': product.price * item.number,
                    'state': item.state
                })
            orders.append({
                'order_id': order_id,
                'total_price': order.total_price,
                'items': items
            })
        return Response({
            'success': True,
            'message': '获取成功',
            'data': {
                'orders': orders
            }
        })


class OrdersAPIView(APIView):
    def get(self, request):
        if request.user.rights != Users.UserType.ADMIN:
            return Response({
                'success': False,
                'message': '权限不足'
            })
        user_id = request.user.id
        all_orders = Orders.objects.filter(user_id=user_id)
        orders = []
        for order in all_orders:
            order_id = order.id
            all_items = OrderItems.objects.filter(order_id=order_id)
            items = []
            for item in all_items:
                product = Products.objects.get(id=item.product_id)
                items.append({
                    'order_item_id': item.id,
                    'product_image': product.image,
                    'product_name': product.name,
                    'sell_address': product.sell_address,
                    'buy_num': item.number,
                    'product_price': product.price * item.number,
                    'state': item.state
                })
            orders.append({
                'order_id': order_id,
                'buyer_id': user_id,
                'total_price': order.total_price,
                'order_time': order.create_at,
                'items': items
            })
        return Response({
            'success': True,
            'message': '获取成功',
            'data': {
                'orders': orders
            }
        })


class DeleteOrderAPIView(APIView):
    def delete(self, request):
        if request.user.rights != Users.UserType.ADMIN:
            return Response({
                'success': False,
                'message': '权限不足'
            })
        order_id = request.kwargs['order_id']
        order = Orders.objects.get(id=order_id)
        order.delete()
        return Response({
            'success': True,
            'message': '删除成功'
        })


class ShowSellOrdersAPIView(APIView):
    def get(self, request):
        all_orders = Orders.objects.all()
        orders = []
        for order in all_orders:
            order_id = order.id
            all_items = OrderItems.objects.filter(order_id=order_id)
            for item in all_items:
                product = Products.objects.get(id=item.product_id)
                if product.user_id == request.user.id:
                    orders.append({
                        'order_id': order_id,
                        'order_item_id': item.id,
                        'order_item_number': item.number,
                        'order_item_state': item.state,
                        'product_id': product.id,
                        'product_name': product.name,
                        'product_price': product.price,
                        'buyer_id': order.user_id,
                        'order_item_time': order.create_at,
                        'order_item_total_price': product.price * item.number,
                    })
        return Response({
            'success': True,
            'message': '获取成功',
            'data': {
                'order_items': orders
            }
        })


class ModifyOrderStatusAPIView(APIView):
    def post(self, request):
        order_item_id = request.data['order_item_id']
        order_item = OrderItems.objects.get(id=order_item_id)
        seller = Products.objects.get(id=order_item.product_id).user_id
        if request.user.rights != Users.UserType.ADMIN and request.user.id != seller.id:
            return Response({
                'success': False,
                'message': '权限不足'
            })
        state = request.data['new_state']
        order_item.state = state
        order_item.save()
        return Response({
            'success': True,
            'message': '修改成功'
        })
