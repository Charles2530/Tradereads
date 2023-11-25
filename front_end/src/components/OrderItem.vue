<template>
  <div class="p-4">
    <div class="flex flex-col bg-white shadow-md p-6 rounded-lg">
      <div class="pb-4 border-b border-gray-200 mb-4">
        <el-row :gutter="20">
          <el-col :span="8">
            <h2 class="text-gray-600 text-2xl font-bold">
              订单:{{ order_id }}
            </h2>
          </el-col>
          <el-col :span="8">
            <div class="mt-2">
              <span class="text-gray-600 text-2xl font-bold"
                >总价: {{ total_price }}</span
              >
            </div>
          </el-col>
          <el-col :span="8">
            <div class="mt-2">
              <span class="text-gray-600 text-2xl font-bold"
                >下单时间: {{ order_time }}</span
              >
            </div>
          </el-col>
        </el-row>
      </div>
      <div
        class="grid grid-cols-1 md:grid-cols-2 gap-4"
        v-for="item in items"
        :key="item.order_item_id"
      >
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
        </div>
      </div>
    </div>
  </div>
</template>

<script>
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
};
</script>
