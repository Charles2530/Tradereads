<template>
  <div class="order-list-page">
    <h1 class="text-4xl font-bold mb-8 flex justify-center">订单列表</h1>
    <div class="search-box">
      <el-input v-model="searchQuery" placeholder="搜索用户订单"></el-input>
    </div>
    <div class="bg-gray-600/80 p-4 rounded-lg shadow-md">
      <el-scrollbar max-height="680px">
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
.search-box {
  margin: 20px 5px 20px 15px;
}
</style>
