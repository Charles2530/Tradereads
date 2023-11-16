<template>
  <div class="p-4">
    <div class="flex flex-col bg-white shadow-md p-6 rounded-lg">
      <div class="pb-4 border-b border-gray-200 mb-4">
        <h2 class="text-2xl font-bold">订单:{{ orderId }}</h2>
        <div class="mt-2">
          <button
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded mt-4"
            @click="updateStatus"
          >
            当前状态: <span class="text-white">{{ currentStatus }}</span>
          </button>
        </div>
      </div>
      <div
        class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4"
        v-for="item in items"
        :key="item.id"
      >
        <div class="border rounded-lg p-4 flex flex-col">
          <span class="text-lg font-semibold">{{ item.title }}</span>
          <span class="text-gray-600">价格: {{ item.price }}</span>
          <span class="text-gray-600">数量: {{ item.quantity }}</span>
          <span>发往: {{ item.shippingAddress }}</span>
          <span
            :class="{
              'text-red-500': item.stockStatus === '售完',
              'text-green-500': item.stockStatus === '有货',
            }"
          >
            {{ item.stockStatus }}
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
    orderId: {
      type: String,
      required: true,
    },
    items: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      currentStatus: "待付款",
      orderStatuses: ["待付款", "待发货", "待收货", "已完成"],
    };
  },
  methods: {
    updateStatus() {
      let currentIndex = this.orderStatuses.indexOf(this.currentStatus);
      let nextIndex = (currentIndex + 1) % this.orderStatuses.length;
      this.currentStatus = this.orderStatuses[nextIndex];
    },
  },
};
</script>
