<template>
  <div
    class="bg-personalCenter-background bg-cover bg-center bg-no-repeat p-4 min-h-screen"
  >
    <div class="headBar">
      <h1 class="text-white text-4xl font-semibold mb-4">个人中心</h1>
    </div>
    <div class="mb-8">
      <h2 class="text-white text-2xl font-semibold mb-4">个人信息</h2>
      <div class="bg-white p-4 rounded-lg shadow-md">
        <div><strong>用户名:</strong> {{ loginInfo.username }}</div>
        <div><strong>邮箱:</strong> {{ loginInfo.email }}</div>
      </div>
    </div>
    <!-- 订单列表展开按钮 -->
    <div class="mb-4">
      <button
        class="text-white font-semibold hover:underline"
        @click="toggleOrders"
      >
        {{ showOrders ? "收起订单列表" : "展开订单列表" }}
      </button>
    </div>

    <!-- 订单列表 -->
    <div v-if="showOrders" class="mb-8">
      <h2 class="text-white text-2xl font-semibold mb-4">订单列表</h2>
      <div class="bg-white p-4 rounded-lg shadow-md">
        <order-item
          v-for="order in orders"
          :key="order.id"
          :order-id="order.id"
          :items="order.items"
        ></order-item>
      </div>
    </div>
    <!-- 商品列表展开按钮 -->
    <div class="mb-4">
      <button
        class="text-white font-semibold hover:underline"
        @click="toggleProducts"
      >
        {{ showProducts ? "收起商品列表" : "展开商品列表" }}
      </button>
    </div>

    <!-- 商品列表 -->
    <div v-if="showProducts">
      <h2 class="text-white text-2xl font-semibold mb-4">商品列表</h2>
      <div class="bg-white p-4 rounded-lg shadow-md">
        <ul>
          <li>商品 #1</li>
          <li>商品 #2</li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
import OrderItem from "../../components/OrderItem.vue";
export default {
  components: {
    OrderItem,
  },
  data: () => ({
    loginInfo: {
      username: "charles",
      email: "charles2530@163.com",
    },
    showOrders: false,
    showProducts: false,
    orders: [
      {
        id: "order1",
        items: [
          {
            id: 1,
            title: "书名一",
            price: "$39.99",
            quantity: 2,
            shippingAddress: "123 主街, 任城, 美国",
            stockStatus: "有货",
          },
        ],
        currentStatus: "待付款",
      },
      {
        id: "order2",
        items: [
          {
            id: 2,
            title: "书名二",
            price: "$29.99",
            quantity: 1,
            shippingAddress: "123 主街, 任城, 美国",
            stockStatus: "售完",
          },
        ],
        currentStatus: "待发货",
      },
    ],
  }),
  methods: {
    toggleOrders() {
      this.showOrders = !this.showOrders;
    },
    toggleProducts() {
      this.showProducts = !this.showProducts;
    },
  },
};
</script>
