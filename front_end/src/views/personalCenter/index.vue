<template>
  <div>
    <section class="shortcut">
      <div class="w">
        <div class="fl">
          <ul>
            <li>二手书网站欢迎您!&nbsp;</li>
            <li>
              <a href="#">退出登录&nbsp;</a>
            </li>
          </ul>
        </div>
        <div class="fr">
          <ul>
            <li>订单信息</li>
            <li></li>
            <li>
              <router-link to="/shopping">我的购物车</router-link>
            </li>
            <li></li>
            <li>
              <router-link to="/ProductBuy">商品中心</router-link>
            </li>
            <li></li>
            <li>我的关注</li>
            <li></li>
            <li>客服服务</li>
            <li></li>
            <li>网站导航</li>
          </ul>
        </div>
      </div>
    </section>
    <div
      class="bg-personalCenter-background bg-cover bg-center bg-no-repeat p-4 min-h-screen"
    >
      <div class="headBar bg-gradient-to-r from-blue-400/50 to-red-500/50">
        <h1 class="text-white text-4xl font-semibold mb-4">个人中心</h1>
        <div class="mb-8">
          <h2 class="text-white text-2xl font-semibold mb-4">个人信息</h2>
          <div class="bg-white p-4 rounded-lg shadow-md">
            <div><strong>用户名:</strong> {{ loginInfo.username }}</div>
            <div><strong>邮箱:</strong> {{ loginInfo.email }}</div>
          </div>
        </div>
        <!-- 订单列表展开按钮 -->
        <div class="mb-4">
          <el-button
            type="primary"
            class="text-white font-semibold hover:underline"
            @click="toggleOrders"
            plain
          >
            {{ showOrders ? "收起订单列表" : "展开订单列表" }}
          </el-button>
        </div>

        <!-- 订单列表 -->
        <div v-if="showOrders" class="mb-8">
          <h2 class="text-white text-2xl font-semibold mb-4">订单列表</h2>
          <div class="bg-gray-600/80 p-4 rounded-lg shadow-md">
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
          <el-button
            type="success"
            class="text-white font-semibold hover:underline"
            @click="toggleProducts"
            plain
          >
            {{ showProducts ? "收起商品列表" : "展开商品列表" }}
          </el-button>
        </div>

        <!-- 商品列表 -->
        <div v-if="showProducts">
          <h2 class="text-white text-2xl font-semibold mb-4">商品列表</h2>
          <div class="bg-gray-600/80 p-4 rounded-lg shadow-md">
            <product-item
              v-for="product in products"
              :key="product.id"
              :product="product"
            ></product-item>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style>
@import url("@css/base.css");
@import url("@css/header.css");
</style>

<script>
import OrderItem from "@c/OrderItem.vue";
import ProductItem from "@c/ProductItem.vue";
import { getUser } from "@/api/user.js";
export default {
  components: {
    OrderItem,
    ProductItem,
  },
  data: () => ({
    loginInfo: {
      username: getUser(1).data.user_name,
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
    products: [
      {
        id: 1,
        title: "书名一",
        price: "$39.99",
        shippingAddress: "123 主街, 任城, 美国",
        stock: 2,
      },
      {
        id: 2,
        title: "书名二",
        price: "$29.99",
        shippingAddress: "123 主街, 任城, 美国",
        stock: 0,
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
