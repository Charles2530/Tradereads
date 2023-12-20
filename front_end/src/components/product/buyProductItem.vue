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
              size="middle"
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
    <el-dialog v-model="dialogVisible" width="30%" @close="closeDialog">
      <div>
        <p class="text-2xl font-bold mb-8 flex justify-center">购买商品</p>
        <h3>{{ product.product_name }}</h3>
        <p>价格: ￥{{ product.price }}</p>
        <span>出版社</span>
        <p>购买数量</p>
        <div class="mt-2">
          <el-button type="primary" @click="buyProduct" plain
            >立即购买</el-button
          >
          <el-button type="success" @click="addToCart" plain
            >加入购物车</el-button
          >
          <el-button type="danger" @click="closeDialog" plain
            >关闭弹窗</el-button
          >
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { ref } from "vue";
export default {
  name: "buyProductItem",
  props: {
    product: {
      type: Object,
      required: true,
    },
  },
  setup(props) {
    const dialogVisible = ref(false);
    const openPurchaseDialog = () => {
      dialogVisible.value = true;
    };
    const closeDialog = () => {
      dialogVisible.value = false;
    };
    const buyProduct = () => {
      // 实现购买商品的逻辑，可以在这里发起支付等操作
      // 例如，可以使用后端API来处理支付流程
      // 然后关闭对话框
      dialogVisible.value = false;
    };
    const addToCart = () => {
      // 实现将商品加入购物车的逻辑，可以在这里将商品信息添加到购物车状态中
      // 例如，可以使用 Vuex 来管理购物车状态
      // 然后关闭对话框
      dialogVisible.value = false;
    };
    return {
      openPurchaseDialog,
      dialogVisible,
      buyProduct,
      addToCart,
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
