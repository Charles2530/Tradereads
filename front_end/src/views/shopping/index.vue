<template>
  <div class="bg-blue-200/70">
    <navigation-bar />
    <div
      class="bg-cart-background bg-cover bg-center bg-no-repeat p-4 min-h-screen pl-12"
    >
      <div style="position: relative; z-index: 1">
        <personal-center-side-bar />
      </div>
      <div style="position: relative; z-index: 0">
        <div>
          <p class="text-4xl font-bold mb-8 flex justify-center text-white">
            我的购物车
          </p>
          <div>
            <el-popconfirm
              title="确定要购买所选商品吗?"
              @confirm="addCartsToOrdersFunc"
            >
              <template #reference>
                <el-button class="ml-8 my-2" type="success" plain>
                  <el-icon class="ml-1 mr-4"><Service /></el-icon>
                  点击购买商品
                </el-button>
              </template>
            </el-popconfirm>
            <el-popconfirm
              title="确定要购买购物车内所有商品吗?"
              @confirm="clearCart"
            >
              <template #reference>
                <el-button type="primary" plain>
                  <el-icon class="ml-1 mr-4"><Remove /></el-icon>
                  清空购物车</el-button
                >
              </template>
            </el-popconfirm>
          </div>
          <div>
            <shopping-item-list :products="cartProducts" />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import shoppingItemList from "@c/shopping/shoppingItemList.vue";
import { onMounted, ref, computed } from "vue";
import {
  showCurrentUserCart,
  addCartsToOrders,
  clearCurrentUserCart,
} from "@/api/cart.js";
import NavigationBar from "@c/home/NavigationBar.vue";
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

const selectIdArray = computed(() => {
  return cartProducts.value.reduce((total, item) => {
    if (item.selected) {
      total.push(item.product_id);
    }
    return total;
  }, []);
});

const clearCart = () => {
  clearCurrentUserCart().then((res) => {
    if (res.success) {
      ElMessage({
        type: "success",
        message: "清空购物车成功",
      });
      location.reload();
    } else {
      ElMessage({
        type: "error",
        message: res.message,
      });
    }
  });
};

const addCartsToOrdersFunc = () => {
  addCartsToOrders({ choose_carts: selectIdArray.value }).then((res) => {
    console.log(selectIdArray.value);
    console.log(res);
    if (res.success) {
      ElMessage({
        type: "success",
        message: "商品购买成功",
      });
    } else {
      ElMessage({
        type: "error",
        message: res.message,
      });
    }
  });
};
</script>
