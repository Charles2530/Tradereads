<template>
  <div class="order-list-page mt-20">
    <div class="search-box">
      <el-row>
        <div class="mx-2">
          <el-icon class="mt-2"><Search /></el-icon>
        </div>
        <div>
          <el-input v-model="searchQuery" placeholder="搜索用户订单"></el-input>
        </div>
        <div>
          <el-switch
            class="mx-4 mb-2"
            v-model="Match"
            style="
              --el-switch-on-color: #13ce66;
              --el-switch-off-color: #ff4949;
            "
            active-text="模糊匹配"
            :active-action-icon="View"
            :inactive-action-icon="Hide"
          />
        </div>
      </el-row>
    </div>
    <div class="bg-gray-600/80 p-4 rounded-lg shadow-md">
      <div class="bg-white p-3">
        <el-scrollbar max-height="500px">
          <order-item-admin
            v-for="order in filteredOrdersPerPage"
            :key="order.order_id"
            :buyer_id="order.buyer_id"
            :order_id="order.order_id"
            :total_price="parseInt(order.total_price)"
            :order_time="order.order_time"
            :items="order.items"
          ></order-item-admin>
          <el-pagination
            :current-page="currentPage"
            :page-size="pageSize"
            :total="filteredOrders.length"
            @current-change="handlePageChange"
            class="px-6"
          />
        </el-scrollbar>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, computed, onMounted } from "vue";
import OrderItemAdmin from "@c/order/OrderItemAdmin.vue";
import { showAllOrders } from "@/api/order";
import { Hide, View } from "@element-plus/icons-vue";
import { useRouter } from "vue-router";
export default {
  name: "OrderListPage",
  setup() {
    onMounted(() => {
      showAllOrderList();
    });
    const all_orders = ref([]);
    const searchQuery = ref("");
    const router = useRouter();
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
          router.push("/404");
        }
      });
    };
    const Match = ref(true);
    const filteredOrders = computed(() => {
      if (!Match.value) {
        console.log(Match.value);
        if (!searchQuery.value) return all_orders.value;
        return all_orders.value.filter(
          (order) => String(order.buyer_id) == searchQuery.value
        );
      } else {
        if (!searchQuery.value) return all_orders.value;
        return all_orders.value.filter((order) =>
          String(order.buyer_id).includes(searchQuery.value)
        );
      }
    });
    const pageSize = ref(3);
    const currentPage = ref(1);
    const filteredOrdersPerPage = computed(() => {
      const start = (currentPage.value - 1) * pageSize.value;
      const end = currentPage.value * pageSize.value;
      return filteredOrders.value.slice(start, end);
    });
    const handlePageChange = (newPage) => {
      currentPage.value = newPage;
    };
    return {
      all_orders,
      showAllOrderList,
      filteredOrders,
      searchQuery,
      OrderItemAdmin,
      pageSize,
      currentPage,
      handlePageChange,
      filteredOrdersPerPage,
      Hide,
      View,
      Match,
    };
  },
};
</script>

<style scoped>
.order-list-page {
  margin: 0 auto;
  padding: 20px;
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
</style>
