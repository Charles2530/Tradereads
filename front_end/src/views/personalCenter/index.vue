<template>
  <div>
    <div>
      <section class="shortcut">
        <div class="w fixed left-28">
          <ul>
            <li>二手书网站欢迎您!&nbsp;</li>
          </ul>
        </div>
      </section>
      <div
        class="bg-personalCenter-background bg-cover bg-center bg-no-repeat p-4 min-h-screen"
      >
        <div
          class="headBar ml-100 bg-gradient-to-r from-blue-400/50 to-red-500/50 rounded-lg shadow-md p-4"
        >
          <personal-info></personal-info>
          <div class="button-container">
            <!-- 订单列表展开按钮 -->
            <div class="mb-4">
              <el-button
                type="primary"
                class="text-white font-semibold hover:underline"
                @click="toggleOrders"
                plain
              >
                {{ showOrders ? "收起订单列表" : "展开订单列表" }}
              </el-button>
            </div>

            <!-- 订单列表 -->
            <div v-if="showOrders" class="mb-8">
              <h2 class="text-white text-2xl font-semibold mb-4">订单列表</h2>
              <div
                class="bg-gray-600/80 p-4 rounded-lg shadow-md order_container"
              >
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
            </div>
            <!-- 商品列表展开按钮 -->
            <div class="mb-4">
              <el-button
                type="success"
                class="text-white font-semibold hover:underline"
                @click="toggleProducts"
                plain
              >
                {{ showProducts ? "收起商品列表" : "展开商品列表" }}
              </el-button>
            </div>

            <!-- 商品列表 -->
            <div v-if="showProducts">
              <h2 class="text-white text-2xl font-semibold mb-4">
                我的商品列表
              </h2>
              <div
                class="bg-gray-600/80 p-4 rounded-lg shadow-md product-container"
              >
                <product-item
                  v-for="product in products"
                  :key="product.product_id"
                  :product="product"
                ></product-item>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div>
      <personal-center-side-bar></personal-center-side-bar>
    </div>
  </div>
</template>

<style>
@import url("@css/base.css");
@import url("@css/header.css");
</style>

<script setup>
import { ref, onMounted } from "vue";
import OrderItem from "@c/order/OrderItem.vue";
import ProductItem from "@c/product/ProductItem.vue";
import personalCenterSideBar from "@c/user/personalCenterSideBar.vue";
import personalInfo from "../../components/user/personalInfo.vue";
import { showCurrentUserOrders } from "@/api/order.js";
import { showProductsList } from "@/api/product.js";
import { userStore } from "@/store/user.js";
// Lifecycle hook
onMounted(() => {
  showCurrentUserOrders().then((res) => {
    if (res.success) {
      console.log(res.data.orders);
      orders.value = res.data.orders;
    }
  });

  showProductsList(store.getToken).then((res) => {
    if (res.success) {
      products.value = res.data.products;
    } else {
      ElMessage({
        showClose: true,
        message: res.message,
        type: "error",
      });
    }
  });
});

const showOrders = ref(false);
const showProducts = ref(false);
const store = userStore();
const orders = ref([]);
const products = ref([]);

// Methods
const toggleOrders = () => {
  showOrders.value = !showOrders.value;
};

const toggleProducts = () => {
  showProducts.value = !showProducts.value;
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
</style>
