<template>
  <div class="user_info mb-10">
    <user-info-item
      :avatar="avatar"
      :user_name="user_name"
      :phone="phone"
    ></user-info-item>
  </div>
  <div class="button-container">
    <!-- 订单列表展开按钮 -->
    <div class="mb-4">
      <el-button
        type="primary"
        class="text-white font-semibold hover:underline"
        @click="openOrderDialog"
        plain
      >
        我的订单列表
      </el-button>
      <el-dialog v-model="showOrderDialog" title="订单列表" width="80%">
        <div class="bg-gray-600/80 p-4 rounded-lg shadow-md order_container">
          <order-item
            v-for="order in orders"
            :key="order.order_id"
            :order_id="order.order_id"
            :buyer_id="parseInt(store.getToken)"
            :total_price="parseInt(order.total_price)"
            :order_time="order.order_time"
            :items="order.items"
          ></order-item>
        </div>
      </el-dialog>
    </div>

    <!-- 商品列表展开按钮 -->
    <div class="mb-4">
      <el-button
        type="success"
        class="text-white font-semibold hover:underline"
        @click="openProductDialog"
        plain
      >
        我的商品列表
      </el-button>
      <el-dialog v-model="showProductDialog" title="我的商品列表" width="80%">
        <div class="bg-gray-600/80 p-4 rounded-lg shadow-md product-container">
          <product-item
            v-for="product in products"
            :key="product.product_id"
            :product="product"
          ></product-item>
        </div>
      </el-dialog>
    </div>
    <div class="button-container">
      <!-- 我的关注展开按钮 -->
      <div class="mb-4">
        <el-button
          type="info"
          class="text-white font-semibold hover:underline"
          @click="openFollowingDialog"
          plain
        >
          我的关注列表
        </el-button>
        <el-dialog v-model="showFollowingDialog" title="我的关注" width="80%">
          <div
            class="bg-gray-600/80 p-4 rounded-lg shadow-md following-container"
          >
            <user-info-item
              v-for="following in followingList"
              :key="following.id"
              :following="following"
            ></user-info-item>
          </div>
        </el-dialog>
      </div>
    </div>
  </div>
</template>
<script setup>
import { onMounted, ref } from "vue";
import OrderItem from "@c/order/OrderItem.vue";
import ProductItem from "@c/product/ProductItem.vue";
import { showCurrentUserOrders } from "@/api/order.js";
import { showProductsList } from "@/api/product.js";
import { getUser } from "@/api/user.js";
import { userStore } from "@/store/user.js";
const store = userStore();
const orders = ref([]);
const products = ref([]);
const showOrderDialog = ref(false);
const showProductDialog = ref(false);
const avatar = ref("");
const user_name = ref("");
const phone = ref("");
// Lifecycle hook
onMounted(() => {
  getUser(store.getToken).then((res) => {
    if (res.success) {
      console.log(res.data);
      avatar.value = res.data.avatar;
      user_name.value = res.data.user_name;
      phone.value = res.data.phone;
    }
  });
});
// Methods
const openOrderDialog = () => {
  showCurrentUserOrders().then((res) => {
    if (res.success) {
      console.log(res.data.orders);
      orders.value = res.data.orders;
      showOrderDialog.value = true;
    }
  });
};

const openProductDialog = () => {
  showProductsList(store.getToken).then((res) => {
    if (res.success) {
      products.value = res.data.products;
      showProductDialog.value = true;
    } else {
      ElMessage({
        showClose: true,
        message: res.message,
        type: "error",
      });
    }
  });
};

const followingList = ref([]);
const showFollowingDialog = ref(false);
const openFollowingDialog = () => {
  // Replace the API call with your actual API function for fetching following list
  /*   showFollowingList().then((res) => {
    if (res.success) {
      followingList.value = res.data.followingList;
      showFollowingDialog.value = true;
    } else {
      ElMessage({
        showClose: true,
        message: res.message,
        type: "error",
      });
    }
  }); */
};
</script>

<style scoped>
.product-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}
.product-item {
  width: calc(50% - 8px); /* 50% width with some spacing */
  margin-bottom: 16px; /* Add some bottom margin for spacing */
}
.following-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}
.following-item {
  width: calc(50% - 8px); /* 50% width with some spacing */
  margin-bottom: 16px; /* Add some bottom margin for spacing */
  /* Additional styling based on your design preferences */
}
</style>