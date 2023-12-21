<template>
  <div class="p-1 border rounded-lg shadow-lg product-item">
    <el-row>
      <el-col :span="24">
        <el-row>
          <img :src="product.product_image" alt="Product Image" />
        </el-row>
        <el-row align="middle" class="mx-2">
          <el-col :span="12">
            <span class="text-md font-bold">{{ product.product_name }}</span>
          </el-col>
          <el-col :span="6">
            <span class="text-md text-gray-600">￥{{ product.price }}</span>
          </el-col>
          <el-col :span="6">
            <el-button
              type="info"
              @click="openPurchaseDialog()"
              plain
              class="my-1"
            >
              <el-icon><ShoppingCartFull /></el-icon>
            </el-button>
          </el-col>
        </el-row>
      </el-col>
    </el-row>
    <el-dialog v-model="dialogVisible" width="35%" @close="closeDialog">
      <div>
        <p class="text-2xl font-bold mb-8 flex justify-center">购买商品</p>
        <p class="text-xl my-2">商品名称: {{ product.product_name }}</p>
        <p class="text-xl my-2">商品价格: ￥{{ product.price }}</p>
        <p class="text-xl my-2">商品出版社: {{ product.product_press }}</p>
        <p class="text-xl my-2">商品类型: {{ product.product_type }}</p>
        <p class="text-xl my-2">商家用户名: {{ product.seller_name }}</p>
        <p class="text-xl my-2">商家发货地址: {{ product.sell_address }}</p>
        <p class="text-xl my-2">
          购买数量:<el-input-number
            class="mx-2"
            v-model="count"
            :min="1"
            :max="30"
          />
        </p>
        <div class="mt-2">
          <el-button type="primary" @click="buyProductFunc" plain
            >立即购买</el-button
          >
          <el-button type="success" @click="addToCart" plain
            >加入购物车</el-button
          >
          <el-button
            type="warning"
            @click="goToProductDetails(product.product_id)"
            plain
            >详细信息</el-button
          >
          <el-button type="info" @click="followUser" plain>
            查看商家信息</el-button
          >
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { ref } from "vue";
import { addProductToCart } from "@/api/product.js";
import { useRouter } from "vue-router";
export default {
  name: "buyProductItem",
  props: {
    product: {
      type: Object,
      required: true,
    },
  },
  setup(props) {
    const router = useRouter();
    const dialogVisible = ref(false);
    const count = ref(1);
    const openPurchaseDialog = () => {
      dialogVisible.value = true;
    };

    const buyProductFunc = () => {
      buyProduct(props.product.id, { count: count }).then((res) => {
        if (res.success) {
          ElMessage({
            type: "success",
            message: "购买成功",
          });
        } else {
          ElMessage({
            showClose: true,
            type: "error",
            message: res.message,
          });
        }
        dialogVisible.value = false;
      });
    };

    const followUser = () => {
      console.log(props.user_id);
      router.push({
        name: "FollowDetail",
        params: {
          user_id: props.product.seller_id,
        },
      });
    };

    const addToCart = () => {
      addProductToCart(props.product.product_id, { count: count.value }).then(
        (res) => {
          if (res.success) {
            ElMessage({
              type: "success",
              message: "添加购物车成功",
            });
          } else {
            ElMessage({
              showClose: true,
              type: "error",
              message: res.message,
            });
          }
          dialogVisible.value = false;
        }
      );
    };

    const goToProductDetails = (productId) => {
      console.log(productId);
      router.push({
        name: "ProductDetail",
        params: {
          product_id: productId,
        },
      });
    };

    return {
      openPurchaseDialog,
      dialogVisible,
      goToProductDetails,
      buyProductFunc,
      addToCart,
      followUser,
      count,
    };
  },
};
</script>

<style scoped>
.product-item {
  width: 18%;
  margin-bottom: 16px;
  margin-right: 1%;
  display: inline-block;
}
</style>
