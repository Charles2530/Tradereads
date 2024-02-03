from django.urls import path
from carts.views import *
urlpatterns = [
    path('show_cart/', ShowCartAPIView, name='show-cart'),
    path('carts_to_orders/', AddCartAPIView, name='add-cart'),
    path('choose_cart_to_order/', AddCartToOrderAPIView, name='add-cart-to-order'),
    path('products/<int:product_id>/remove_from_cart', RemoveFromCartAPIView, name='remove-from-cart'),
]