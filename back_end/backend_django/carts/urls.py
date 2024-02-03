from django.urls import path
from carts.views import *

urlpatterns = [
    path('show_cart/', ShowCartAPIView.as_view(), name='show-cart'),
    path('carts_to_orders/', AddCartAPIView.as_view(), name='add-cart'),
    path('choose_cart_to_order/', AddCartToOrderAPIView.as_view(), name='add-cart-to-order'),
    path('products/<int:product_id>/remove_from_cart', RemoveFromCartAPIView.as_view(), name='remove-from-cart'),
]
