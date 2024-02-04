from rest_framework import serializers
from .models import *


class RegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = Users
        fields = ['phone', 'user_name', 'gender', 'password']

    def create(self, validated_data):
        user = Users.objects.create(
            phone=validated_data['phone'],
            user_name=validated_data['user_name'],
            password=validated_data['password'],
            gender=validated_data['gender'],
        )
        return user

