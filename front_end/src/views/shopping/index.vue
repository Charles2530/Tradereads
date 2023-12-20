<template>
  <div class="bg-blue-200/70">
    <navigation-bar />
    <div class="p-4 min-h-screen pl-12">
      <div style="position: relative; z-index: 1">
        <personal-center-side-bar />
      </div>
      <div style="position: relative; z-index: 0">
        <div>
          <p class="text-4xl font-bold mb-8 flex justify-center">我的购物车</p>
          <div>
            <el-button
              class="ml-4"
              type="success"
              @click="addCartsToOrdersFunc()"
              plain
            >
              添加商品到订单
            </el-button>
          </div>
          <div class="bg-white ml-8">
            <shopping-item-list :products="cartProducts" />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import shoppingItemList from "@c/shopping/shoppingItemList.vue";
import { onMounted, ref } from "vue";
import { showCurrentUserCart, addCartsToOrders } from "@/api/cart.js";
import NavigationBar from "@c/home/NavigationBar.vue";
import { ElMessage } from "element-plus";
onMounted(() => {
  showCurrentUserCart().then((res) => {
    if (res.success) {
      console.log(res.data.products);
      cartProducts.value = res.data.products;
    } else {
      ElMessage({
        showClose: true,
        type: "error",
        message: res.message,
      });
    }
  });
});
const cartProducts = ref([]);
const addCartsToOrdersFunc = () => {
  addCartsToOrders().then((res) => {
    if (res.success) {
      ElMessage({
        showClose: true,
        type: "success",
        message: res.message,
      });
      location.reload();
    } else {
      ElMessage({
        showClose: true,
        type: "error",
        message: res.message,
      });
    }
  });
};
</script>
