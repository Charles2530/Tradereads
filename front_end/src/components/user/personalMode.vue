<template>
  <div class="user_info mb-4">
    <user-info-item-simplify
      :avatar="avatar"
      :user_name="user_name"
    ></user-info-item-simplify>
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
        <el-icon class="ml-1 mr-4"><MessageBox /></el-icon>
        我的购买订单
      </el-button>
      <el-dialog v-model="showOrderDialog" title="订单列表" width="80%">
        <div v-if="orders.length === 0" class="text-center">
          <el-text type="warning">暂无订单</el-text>
        </div>
        <div v-else>
          <div class="bg-gray-600/80 p-4 rounded-lg shadow-md order_container">
            <el-scrollbar max-height="450px">
              <order-item
                v-for="order in orders"
                :key="order.order_id"
                :order_id="order.order_id"
                :total_price="parseInt(order.total_price)"
                :order_time="order.order_time"
                :items="order.items"
              ></order-item>
            </el-scrollbar>
          </div>
        </div>
      </el-dialog>
    </div>
    <!-- 添加我的销售订单展开按钮 -->
    <div class="mb-4">
      <el-button
        type="warning"
        class="text-white font-semibold hover:underline"
        @click="openSalesOrderDialog"
        plain
      >
        <el-icon class="ml-1 mr-4"><Files /></el-icon>
        我的销售订单
      </el-button>
      <el-dialog
        v-model="showSalesOrderDialog"
        title="销售订单列表"
        width="80%"
      >
        <div v-if="salesOrders.length === 0" class="text-center">
          <el-text type="warning">暂无销售订单</el-text>
        </div>
        <div v-else>
          <div
            class="bg-gray-600/80 p-4 rounded-lg shadow-md sales-order-container"
          >
            <el-scrollbar max-height="450px">
              <sales-order-item
                v-for="salesOrder in salesOrders"
                :key="salesOrder.order_id"
                :order_id="salesOrder.order_id"
                :seller_id="salesOrder.buyer_id"
                :total_price="parseInt(salesOrder.total_price)"
                :order_time="salesOrder.order_time"
                :items="salesOrder.items"
              ></sales-order-item>
            </el-scrollbar>
          </div>
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
        <el-icon class="ml-1 mr-4"><Reading /></el-icon>
        我的销售商品
      </el-button>
      <el-dialog v-model="showProductDialog" title="我的商品列表" width="80%">
        <div v-if="products.length === 0" class="text-center">
          <el-text type="warning">暂无销售商品</el-text>
        </div>
        <div v-else>
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
          <el-icon class="ml-1 mr-4"><UserFilled /></el-icon>
          我的关注列表
        </el-button>
        <el-dialog v-model="showFollowingDialog" width="70%">
          <el-scrollbar max-height="450px">
            <following-list :followingList="followList"></following-list>
          </el-scrollbar>
        </el-dialog>
      </div>
    </div>
  </div>
</template>
<script>
import { onMounted, ref } from "vue";
import OrderItem from "@c/order/OrderItem.vue";
import ProductItem from "@c/product/ProductItem.vue";
import followingList from "@c/follow/followingList.vue";
import { showCurrentUserOrders } from "@/api/order.js";
import { showProductsList } from "@/api/product.js";
import { getUser } from "@/api/user.js";
import { userStore } from "@/store/user.js";
import { showCurrentUserFollowings } from "@/api/follow";
export default {
  name: "personalMode",
  components: {
    OrderItem,
    ProductItem,
    followingList,
  },
  props: {
    user_id: {
      type: Number,
      default: -1,
    },
  },
  setup(props) {
    const store = userStore();
    const orders = ref([]);
    const products = ref([]);
    const showOrderDialog = ref(false);
    const showProductDialog = ref(false);
    const avatar = ref("");
    const user_name = ref("");
    const phone = ref("");
    const user_id = props.user_id === -1 ? store.getToken : props.user_id;
    // Lifecycle hook
    onMounted(() => {
      getUser(user_id).then((res) => {
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
      showProductsList(user_id).then((res) => {
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

    const followList = ref([]);
    const showFollowingDialog = ref(false);
    const openFollowingDialog = () => {
      showCurrentUserFollowings().then((res) => {
        if (res.success) {
          console.log(res.data.followings);
          followList.value = res.data.followings;
          showFollowingDialog.value = true;
        } else {
          ElMessage({
            showClose: true,
            message: res.message,
            type: "error",
          });
        }
      });
    };

    const salesOrders = ref([]);
    const showSalesOrderDialog = ref(false);
    const openSalesOrderDialog = () => {
      showCurrentUserOrders().then((res) => {
        if (res.success) {
          console.log(res.data.orders);
          salesOrders.value = res.data.orders;
          showSalesOrderDialog.value = true;
        }
      });
    };
    return {
      store,
      orders,
      products,
      showOrderDialog,
      showProductDialog,
      avatar,
      user_name,
      phone,
      openOrderDialog,
      openProductDialog,
      followList,
      showFollowingDialog,
      openFollowingDialog,
      salesOrders,
      showSalesOrderDialog,
      openSalesOrderDialog,
    };
  },
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
