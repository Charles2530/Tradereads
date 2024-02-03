from django.urls import path
from orders.views import *

urlpatterns = [
    path('show_current_orders/', ShowAllOrdersAPIView.as_view(), name='order-list'),
    path('orders/', OrdersAPIView.as_view(), name='add-order'),
    path('orders/<int:order_id>/', DeleteOrderAPIView.as_view(), name='delete-order'),
    path('show_sell_orders/', ShowSellOrdersAPIView.as_view(), name='show-sell-orders'),
    path('order_items/<int:order_item_id>/modify_order_item_state/', ModifyOrderStatusAPIView.as_view(),
         name='modify-order-status'),
]
