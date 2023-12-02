<template>
  <div class="p-4">
    <div class="flex flex-col bg-white shadow-md p-6 rounded-lg">
      <div class="pb-4 border-b border-gray-200 mb-4">
        <el-row :gutter="22">
          <el-col :span="4">
            <div class="mt-2">
              <h2 class="text-gray-600 text-2xl font-bold">
                订单:{{ order_id }}
              </h2>
            </div>
          </el-col>
          <el-col :span="4">
            <div class="mt-2">
              <span class="text-gray-600 text-2xl font-bold"
                >买家: {{ buyer_id }}</span
              >
            </div>
          </el-col>
          <el-col :span="4">
            <div class="mt-2">
              <span class="text-gray-600 text-2xl font-bold"
                >总价: {{ total_price }}</span
              >
            </div>
          </el-col>
          <el-col :span="10">
            <div class="mt-2">
              <span class="text-gray-600 text-2xl font-bold"
                >下单时间: {{ order_time }}</span
              >
            </div>
          </el-col>
        </el-row>
      </div>
      <div class="order-container">
        <div class="order-item" v-for="item in items" :key="item.order_item_id">
          <div
            class="border rounded-lg p-4 flex flex-col shadow-md hover:shadow-lg transition-shadow duration-300"
          >
            <span class="text-lg font-semibold">{{ item.product_name }}</span>
            <span class="text-gray-600">价格: {{ item.product_price }}</span>
            <span class="text-gray-600">数量: {{ item.buy_num }}</span>
            <span class="text-gray-600">发往: {{ item.sell_address }}</span>
            <span
              :class="{
                'text-red-500': item.state === '待支付',
                'text-yellow-500': item.state === '待发货',
                'text-blue-500': item.state === '待收货',
                'text-green-500': item.state === '已完成',
              }"
            >
              订单状态: {{ item.state }}
            </span>
            <el-select
              v-model="selectedStatus"
              class="m-2"
              placeholder="选择订单状态"
              size="large"
            >
              <el-option
                v-for="status in orderStatusOptions"
                :key="status.value"
                :label="status.label"
                :value="status.value"
              />
            </el-select>
            <el-button type="primary" @click="modifyOrderStatus"
              >修改订单状态</el-button
            >
            <div></div>
          </div>
        </div>

        <el-popconfirm
          title="Are you sure to delete this?"
          @confirm="deleteThisOrder"
        >
          <template #reference>
            <el-button>删除订单</el-button>
          </template>
        </el-popconfirm>
      </div>
    </div>
  </div>
</template>

<script>
import { deleteOrder } from "@/api/order.js";
import { ref } from "vue";
export default {
  name: "SalesOrderItem",
  props: {
    order_id: {
      type: Number,
      required: true,
    },
    buyer_id: {
      type: Number,
      required: true,
    },
    total_price: {
      type: Number,
      required: true,
    },
    items: {
      type: Array,
      required: true,
    },
    order_time: {
      type: String,
      required: true,
    },
  },
  setup() {
    const orderStatusOptions = [
      {
        value: "待支付",
        label: "待支付",
      },
      {
        value: "待发货",
        label: "待发货",
      },
      {
        value: "待收货",
        label: "待收货",
      },
      {
        value: "已完成",
        label: "已完成",
      },
    ];
    const selectedStatus = ref("");
    const deleteThisOrder = () => {
      deleteOrder(this.order_id)
        .then((res) => {
          console.log(res);
          if (res.success) {
            ElMessage({
              message: "删除成功",
              type: "success",
            });
          } else {
            ElMessage({
              message: res.message,
              type: "error",
            });
          }
        })
        .catch((err) => {
          console.log(err);
        });
      window.location.reload();
    };
    const modifyOrderStatus = () => {
      // Call your API function to update the order status here
      // Use this.order_id to get the current order ID
      // Update the 'state' property in each item of the 'items' array with the newStatus value
      // Example API call:
      //   modifyOrderStatusApi(this.order_id, newStatus)
      //     .then((res) => {
      //       console.log(res);
      //       if (res.success) {
      //         ElMessage({
      //           message: "订单状态修改成功",
      //           type: "success",
      //         });
      //       } else {
      //         ElMessage({
      //           message: res.message,
      //           type: "error",
      //         });
      //       }
      //     })
      //     .catch((err) => {
      //       console.log(err);
      //     });
    };
    return {
      orderStatusOptions,
      selectedStatus,
      modifyOrderStatus,
      deleteThisOrder,
    };
  },
};
</script>

<style scoped>
.order-container {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem; /* 调整间距，根据需要调整 */
}

.order-item {
  width: calc(50% - 1rem); /* 计算 50% 宽度，并减去间距 */
  box-sizing: border-box;
}
</style>
