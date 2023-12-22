<template>
  <div class="p-1 border rounded-lg shadow-lg product-item">
    <el-row>
      <el-col :span="24">
        <el-row>
          <img
            :src="product.product_image"
            alt="Product Image"
            class="w-48 h-60"
          />
        </el-row>
        <el-row align="middle" class="mx-2">
          <el-col :span="12">
            <span class="text-md font-bold text-gray-400">{{
              product.product_name
            }}</span>
          </el-col>
          <el-col :span="6">
            <span class="text-md text-red-500 font-bold"
              >￥{{ product.price }}</span
            >
          </el-col>
          <el-col :span="6">
            <el-button
              type="warning"
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
    <el-dialog v-model="dialogVisible" width="40%" @close="closeDialog">
      <div>
        <p class="text-2xl font-bold mb-8 flex justify-center">
          <strong>购买商品</strong>
        </p>
        <p class="text-xl my-2">
          <strong>商品名称: </strong> {{ product.product_name }}
        </p>
        <p class="text-xl my-2">
          <strong>商品价格: </strong>
          <span class="text-md text-red-500 font-bold"
            >￥{{ product.price }}</span
          >
        </p>
        <p class="text-xl my-2">
          <strong>商品出版社: </strong> {{ product.product_press }}
        </p>
        <p class="text-xl my-2">
          <strong>商品类型: </strong> {{ product.product_type }}
        </p>
        <p class="text-xl my-2">
          <strong>商家用户名: </strong> {{ product.seller_name }}
        </p>
        <p class="text-xl my-2">
          <strong>商家发货地址: </strong> {{ product.sell_address }}
        </p>
        <p class="text-xl my-2">
          <strong>购买数量: </strong
          ><el-input-number class="mx-2" v-model="count" :min="1" :max="30" />
        </p>
        <div class="mt-2">
          <el-button type="primary" @click="buyProductFunc" plain>
            <el-icon class="mr-3"><Discount /></el-icon>
            立即购买</el-button
          >
          <el-button type="success" @click="addToCart" plain>
            <el-icon class="mr-3"><DataAnalysis /></el-icon>
            加入购物车</el-button
          >
          <el-button
            type="warning"
            @click="goToProductDetails(product.product_id)"
            plain
          >
            <el-icon class="mr-3"><More /></el-icon>
            详细信息</el-button
          >
          <el-button type="info" @click="followUser" plain>
            <el-icon class="mr-3"><Odometer /></el-icon>
            查看商家信息</el-button
          >
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { ref } from "vue";
import { addProductToCart, buyProduct } from "@/api/product.js";
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
      buyProduct(props.product.product_id, { count: count.value }).then(
        (res) => {
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
        }
      );
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

    const closeDialog = () => {
      dialogVisible.value = false;
    };

    return {
      openPurchaseDialog,
      dialogVisible,
      goToProductDetails,
      buyProductFunc,
      addToCart,
      followUser,
      count,
      closeDialog,
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
