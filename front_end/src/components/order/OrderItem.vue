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
                >总价: {{ total_price }}</span
              >
            </div>
          </el-col>
          <el-col :span="12">
            <div class="mt-2">
              <span class="text-gray-600 text-2xl font-bold"
                >下单时间: {{ order_time }}</span
              >
            </div>
          </el-col>
          <el-col :span="2">
            <div class="mt-2">
              <el-popconfirm
                title="确定要删除此订单吗?"
                @confirm="deleteThisOrder"
              >
                <template #reference>
                  <el-button type="danger">删除订单</el-button>
                </template>
              </el-popconfirm>
            </div>
          </el-col>
        </el-row>
      </div>
      <div class="order-container">
        <el-table :data="items" style="width: 100%">
          <el-table-column
            prop="product_name"
            label="产品名称"
          ></el-table-column>
          <el-table-column prop="product_price" label="价格"></el-table-column>
          <el-table-column prop="buy_num" label="数量"></el-table-column>
          <el-table-column prop="sell_address" label="发往"></el-table-column>
          <el-table-column prop="state" label="订单状态"></el-table-column>
        </el-table>
      </div>
    </div>
  </div>
</template>

<script>
import { deleteOrder } from "@/api/order.js";
export default {
  name: "OrderItem",
  props: {
    order_id: {
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
  methods: {
    deleteThisOrder() {
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
    },
  },
};
</script>
