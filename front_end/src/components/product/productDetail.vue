<template>
  <div>
    <p class="text-2xl font-bold mb-8 flex justify-center">购买商品</p>
    <p class="text-xl my-2">商品名称: {{ product.product_name }}</p>
    <p class="text-xl my-2">商品价格: ￥{{ product.price }}</p>
    <p class="text-xl my-2">商品出版社: {{ product.product_press }}</p>
    <p class="text-xl my-2">商品类型: {{ product.product_type }}</p>
    <p class="text-xl my-2">商家用户名: {{ product.seller_name }}</p>
    <p class="text-xl my-2">商家发货地址: {{ product.sell_address }}</p>

    <div class="mt-2">
      <el-button type="warning" @click="goToProductDetails(product_id)" plain
        >详细信息</el-button
      >
      <el-button type="info" @click="followUser" plain> 查看商家信息</el-button>
    </div>
  </div>
</template>

<script>
import { useRouter } from "vue-router";
export default {
  name: "productDetail",
  props: {
    product: {
      type: Object,
      required: true,
    },
    product_id: {
      type: Number,
      required: true,
    },
  },
  setup(props) {
    const router = useRouter();

    const followUser = () => {
      router.push({
        name: "FollowDetail",
        params: {
          user_id: props.product.seller_id,
        },
      });
    };

    const goToProductDetails = (product_id) => {
      console.log(product_id);
      router.push({
        name: "ProductDetail",
        params: {
          product_id,
        },
      });
    };

    return {
      goToProductDetails,
      followUser,
    };
  },
};
</script>
