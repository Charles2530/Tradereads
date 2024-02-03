from django.urls import path
from products.views import *

urlpatterns = [
    # products
    path('show_products/', ShowAllProductsAPIView.as_view(), name='product-list'),
    path('products/', AddProductAPIView.as_view(), name='add-product'),
    path('products/<int:product_id>/', ProductDetailAPIView.as_view(), name='product-detail'),
    path('users/<int:user_id>/show_product_list/', UserProductsAPIView.as_view(), name='user-products'),
    path('products/<int:product_id>/modify_store/', ModifyStoreAPIView.as_view(), name='modify-store'),
    path('products/<int:product_id>/modify_price/', ModifyPriceAPIView.as_view(), name='modify-price'),
    path('products/<int:product_id>/modify_sell_address/', ModifySellAddressAPIView.as_view(),
         name='modify-sell-address'),
    path('products/<int:product_id>/add_product_to_cart/', AddProductToCartAPIView.as_view(),
         name='modify-product-to-cart'),
    path('products/<int:product_id>/', RemoveProductAPIView.as_view(), name='remove-product'),
    path('products/<int:product_id>/buy_product/', BuyProductAPIView.as_view(), name='buy-product'),
    path('products/<int:product_id>/modify_product_name/', ModifyProductNameAPIView.as_view(),
         name='modify-product-name'),
    path('upload_image/', UploadImageAPIView.as_view(), name='upload-image'),
    # check
    path('products/check_product/', CheckProductAPIView.as_view(), name='check-product'),
    path('products/<int:product_id>/check_product/', ModifyProductStateAPIView.as_view(), name='modify-product-state'),
    # comments
    path('products/<int:product_id>/add_comment/', AddCommentAPIView.as_view(), name='add-comment'),
    path('comments/<int:comment_id>/', DeleteCommentAPIView.as_view(), name='delete-comment'),
    path('products/<int:product_id>/show_comments/', ShowCommentsAPIView.as_view(), name='show-comments'),
    # statistics
    path('product_type_number/', ProductTypeNumberAPIView.as_view(), name='product-type-number'),
    path('user_sell_rank/', UserSellRankAPIView.as_view(), name='user-sell-rank'),
]
