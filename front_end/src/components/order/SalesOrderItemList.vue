<template>
  <el-table :data="orders" style="width: 100%">
    <el-table-column prop="order_id" label="订单" width="80px" />
    <el-table-column prop="buyer_id" label="买家" min-width="100px" />
    <el-table-column prop="product_name" label="产品名" min-width="100px" />
    <el-table-column prop="order_item_total_price" label="总价" width="100px" />
    <el-table-column
      prop="order_item_time"
      label="下单时间"
      min-width="180px"
    />
    <el-table-column label="订单状态" min-width="100px">
      <template #default="scope">
        <div class="text-xl ml-2">
          <span
            :class="{
              'text-red-500': scope.row.order_item_state === '待支付',
              'text-yellow-500': scope.row.order_item_state === '待发货',
              'text-blue-500': scope.row.order_item_state === '待收货',
              'text-green-500': scope.row.order_item_state === '已完成',
            }"
          >
            {{ scope.row.order_item_state }}
          </span>
        </div>
      </template>
    </el-table-column>
    <el-table-column label="修改订单状态" min-width="200px">
      <template #default="scope">
        <div class="w-40">
          <el-select
            v-model="scope.row.order_item_state"
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
        </div>
        <div class="ml-2">
          <el-button type="primary" @click="modifyOrderState">
            <el-icon class="mr-3"><Delete /></el-icon>
            修改订单状态</el-button
          >
        </div>
      </template>
    </el-table-column>
  </el-table>
</template>

<script>
import { deleteOrder, modifyOrderStatus } from "@/api/order.js";
export default {
  name: "SalesOrderItemList",
  props: {
    orders: {
      type: Object,
      required: true,
    },
  },
  setup(props) {
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

    const modifyOrderState = () => {
      modifyOrderStatus(props.order.order_item_id, {
        new_state: props.order.order_item_state,
      })
        .then((res) => {
          if (res.success) {
            ElMessage({
              message: "订单项状态修改成功",
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
    };
    return {
      orderStatusOptions,
      modifyOrderStatus,
      modifyOrderState,
      deleteThisOrder,
    };
  },
};
</script>
