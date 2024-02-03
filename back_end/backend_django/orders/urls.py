from django.urls import path
from orders.views import *
urlpatterns = [
    path('show_current_orders/', ShowAllOrdersAPIView, name='order-list'),
    path('orders/', OrdersAPIView, name='add-order'),
    path('orders/<int:order_id>/', DeleteOrderAPIView, name='delete-order'),
    path('show_sell_orders/', ShowSellOrdersAPIView, name='show-sell-orders'),
    path('order_items/<int:order_item_id>/modify_order_item_state/', ModifyOrderStatusAPIView, name='modify-order-status'),
]