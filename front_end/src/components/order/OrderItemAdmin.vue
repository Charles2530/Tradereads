<template>
  <div class="p-4">
    <div class="flex flex-col bg-white shadow-md p-6 rounded-lg">
      <div class="pb-4 border-b border-gray-800 mb-4">
        <el-row :gutter="22">
          <el-row :span="5">
            <div class="mt-2">
              <span class="text-gray-600 text-2xl font-bold"
                >买家ID: {{ buyer_id }}</span
              >
            </div>
          </el-row>
          <el-col :span="5">
            <div class="mt-2">
              <span class="text-gray-600 text-2xl font-bold"
                >买家: {{ buyer_name }}</span
              >
            </div>
          </el-col>
          <el-col :span="5">
            <div class="mt-2">
              <span class="text-gray-600 text-2xl font-bold"
                >总价: {{ total_price }}</span
              >
            </div>
          </el-col>
          <el-col :span="8">
            <div class="mt-2">
              <span class="text-gray-600 text-2xl font-bold"
                >下单时间: {{ formatDate(order_time) }}</span
              >
            </div>
          </el-col>
          <el-col :span="1">
            <div class="mt-2 mr-4">
              <el-popconfirm
                title="确定要删除此订单吗?"
                @confirm="deleteThisOrder"
              >
                <template #reference>
                  <el-button type="danger" :icon="Delete" circle />
                </template>
              </el-popconfirm>
            </div>
          </el-col>
        </el-row>
      </div>
      <div class="order-container">
        <el-table :data="items" style="width: 100%" border stripe>
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
import { Delete } from "@element-plus/icons-vue";
import { getUser } from "@/api/user.js";
import { ref, onMounted } from "vue";
export default {
  name: "OrderItemAdmin",
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
  setup(props) {
    const formatDate = (dateString) => {
      const options = { year: "numeric", month: "long", day: "numeric" };
      return new Date(dateString).toLocaleDateString(undefined, options);
    };
    const buyer_name = ref("");
    onMounted(() => {
      getUser(props.buyer_id).then((res) => {
        buyer_name.value = res.data.user_name;
      });
    });
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
    return {
      deleteThisOrder,
      Delete,
      formatDate,
      buyer_name,
    };
  },
};
</script>
