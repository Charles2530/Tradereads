<template>
  <div class="bg-red-500 p-4">
    <div class="headBar">
      <h1 class="text-white text-4xl font-semibold mb-4">个人中心</h1>
    </div>
    <div class="mb-8">
      <h2 class="text-white text-2xl font-semibold mb-4">个人信息</h2>
      <div class="bg-black p-4 rounded-lg shadow-md">
        <div><strong>用户名:</strong> {{ loginInfo.username }}</div>
        <div><strong>邮箱:</strong> {{ loginInfo.email }}</div>
      </div>
    </div>

    <div class="mb-8">
      <h2 class="text-white text-2xl font-semibold mb-4">订单列表</h2>
      <div class="bg-black p-4 rounded-lg shadow-md">
        <ul>
          <li>订单 #1</li>
          <li>订单 #2</li>
        </ul>
      </div>
    </div>

    <div>
      <h2 class="text-white text-2xl font-semibold mb-4">商品列表</h2>
      <div class="bg-black p-4 rounded-lg shadow-md">
        <ul>
          <li>商品 #1</li>
          <li>商品 #2</li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
import { userStore } from "../../store/user.js";
export default {
  data: () => ({
    loginInfo: {
      username: "charles",
      //   username: userStore().$state.userInfo.username,
      email: "charles2530@163.com",
      //   email: userStore().$state.userInfo.email,
    },
  }),
};
</script>
