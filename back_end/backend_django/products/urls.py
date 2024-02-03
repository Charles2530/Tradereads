from django.urls import path
from products.views import *

urlpatterns = [
    # products
    path('show_products/', ShowAllProductsAPIView, name='product-list'),
    path('products/', AddProductAPIView, name='add-product'),
    path('products/<int:product_id>/', ProductDetailAPIView, name='product-detail'),
    path('users/<int:user_id>/show_product_list/', UserProductsAPIView, name='user-products'),
    path('products/<int:product_id>/modify_store/', ModifyStoreAPIView, name='modify-store'),
    path('products/<int:product_id>/modify_price/', ModifyPriceAPIView, name='modify-price'),
    path('products/<int:product_id>/modify_sell_address/', ModifySellAddressAPIView, name='modify-sell-address'),
    path('products/<int:product_id>/add_product_to_cart/', AddProductToCartAPIView, name='modify-product-to-cart'),
    path('products/<int:product_id>/', RemoveProductAPIView, name='remove-product'),
    path('products/<int:product_id>/buy_product/', BuyProductAPIView, name='buy-product'),
    path('products/<int:product_id>/modify_product_name/', ModifyProductNameAPIView, name='modify-product-name'),
    path('upload_image/', UploadImageAPIView, name='upload-image'),
    # check
    path('products/check_product/', CheckProductAPIView, name='check-product'),
    path('products/<int:product_id>/check_product/', ModifyProductStateAPIView, name='modify-product-state'),
    # comments
    path('products/<int:product_id>/add_comment/', AddCommentAPIView, name='add-comment'),
    path('comments/<int:comment_id>/', DeleteCommentAPIView, name='delete-comment'),
    path('products/<int:product_id>/show_comments/', ShowCommentsAPIView, name='show-comments'),
    # statistics
    path('product_type_number/', ProductTypeNumberAPIView, name='product-type-number'),
    path('user_sell_rank/', UserSellRankAPIView, name='user-sell-rank'),
]
