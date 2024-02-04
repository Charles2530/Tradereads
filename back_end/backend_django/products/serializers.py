from rest_framework import serializers
from .models import *


class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Products
        fields = ['price', 'sell_address', 'store', 'product_name',
                  'product_image', 'product_press', 'product_type']

    def create(self, validated_data):
        product = Products.objects.create(
            price=validated_data['price'],
            sell_address=validated_data['sell_address'],
            store=validated_data['store'],
            product_name=validated_data['product_name'],
            product_image=validated_data['product_image'],
            product_press=validated_data['product_press'],
            product_type=validated_data['product_type']
        )
        return product
