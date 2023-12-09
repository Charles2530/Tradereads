<template>
  <div class="order-list-page mt-20">
    <h1 class="text-4xl font-bold mb-8 flex justify-center">订单列表</h1>
    <div class="search-box">
      <el-row>
        <div class="mx-2">
          <el-icon class="mt-2"><Search /></el-icon>
        </div>
        <div>
          <el-input v-model="searchQuery" placeholder="搜索用户订单"></el-input>
        </div>
      </el-row>
    </div>
    <div class="bg-gray-600/80 p-4 rounded-lg shadow-md">
      <el-scrollbar max-height="600px">
        <order-item-admin
          v-for="order in filteredOrders"
          :key="order.order_id"
          :buyer_id="order.buyer_id"
          :order_id="order.order_id"
          :total_price="order.total_price"
          :order_time="order.order_time"
          :items="order.items"
        ></order-item-admin>
      </el-scrollbar>
    </div>
  </div>
</template>

<script>
import { ref, computed, onMounted } from "vue";
import OrderItemAdmin from "@c/order/OrderItemAdmin.vue";
import { showAllOrders } from "@/api/order";
export default {
  name: "OrderListPage",
  setup() {
    onMounted(() => {
      showAllOrderList();
    });
    const all_orders = ref([]);
    const searchQuery = ref("");
    const showAllOrderList = () => {
      showAllOrders().then((res) => {
        if (res.success) {
          console.log(res.data.orders);
          all_orders.value = res.data.orders;
        } else {
          ElMessage({
            showClose: true,
            message: res.message,
            type: "error",
          });
        }
      });
    };
    const filteredOrders = computed(() => {
      if (!searchQuery.value) return all_orders.value;
      return all_orders.value.filter((order) =>
        String(order.buyer_id).includes(searchQuery.value)
      );
    });
    return {
      all_orders,
      showAllOrderList,
      filteredOrders,
      searchQuery,
      OrderItemAdmin,
    };
  },
};
</script>

<style scoped>
.order-list-page {
  margin: 0 auto;
  padding: 20px;
}

h1 {
  color: #333;
  font-family: "Helvetica Neue", sans-serif;
}

.search-box {
  justify-content: center;
  margin-bottom: 20px;
}

.search-box el-input {
  max-width: 500px;
  width: 100%;
  transition: all 0.3s ease;
}

.search-box el-input:hover {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
}

.order-item-admin {
  background-color: #fff;
  border: 1px solid #eaeaea;
  border-radius: 8px;
  margin-bottom: 15px;
  padding: 15px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;
}

.order-item-admin:hover {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* 其他需要的样式 */
</style>
