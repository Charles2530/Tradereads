from django.shortcuts import render
from rest_framework.views import APIView


# Create your views here.
# products
class ShowAllProductsAPIView(APIView):
    pass


class AddProductAPIView(APIView):
    pass


class ProductDetailAPIView(APIView):
    pass


class UserProductsAPIView(APIView):
    pass


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
