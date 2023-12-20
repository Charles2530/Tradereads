<template>
  <div class="p-1 border rounded-lg shadow-lg my-4">
    <p class="text-2xl font-bold mb-8 flex justify-center">购买商品</p>

    <div class="flex">
      <!-- 商品信息部分 -->
      <div class="flex-grow">
        <p class="text-xl my-2">商品名称: {{ product.product_name }}</p>
        <p class="text-xl my-2">商品价格: ￥{{ product.price }}</p>
        <p class="text-xl my-2">商品出版社: {{ product.product_press }}</p>
        <p class="text-xl my-2">商品类型: {{ product.product_type }}</p>
        <p class="text-xl my-2">商家用户名: {{ product.seller_name }}</p>
        <p class="text-xl my-2">商家发货地址: {{ product.sell_address }}</p>

        <div class="mt-2">
          <el-button type="warning" @click="followUser" plain>
            <el-icon class="ml-1 mr-4"><EditPen /></el-icon>
            查看商家信息
          </el-button>
        </div>
      </div>

      <div class="ml-4">
        <img
          :src="product.product_image"
          alt="商品图片"
          class="w-64 mx-24 my-2"
        />
      </div>
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

    return {
      followUser,
    };
  },
};
</script>
