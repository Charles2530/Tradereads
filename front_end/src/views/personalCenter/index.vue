<template>
  <div>
    <section class="shortcut">
      <div class="w">
        <div class="fl">
          <ul>
            <li>二手书网站欢迎您!&nbsp;</li>
            <li>
              <button @click="Logout">退出登录</button>
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
            <div><strong>用户名:</strong> {{ loginInfo.user_name }}</div>
            <div><strong>用户电话:</strong> {{ loginInfo.phone }}</div>
            <div><strong>用户地址:</strong> {{ loginInfo.buy_address }}</div>
            <div><strong>性别:</strong> {{ loginInfo.gender }}</div>
            <div><strong>支付方式:</strong> {{ loginInfo.pay_type }}</div>
          </div>
          <div class="mb-4">
            <el-button
              type="info"
              class="text-white font-semibold hover:underline"
              @click="openDialog = true"
              plain
            >
              修改个人信息
            </el-button>
          </div>
          <el-dialog title="修改个人信息" v-model="openDialog" width="30%">
            <div>
              <el-input
                v-model="new_username"
                placeholder="新用户名"
                clearable
              ></el-input>
              <el-input
                v-model="new_address"
                placeholder="新购买地址"
                clearable
              ></el-input>
              <el-input
                v-model="old_password"
                placeholder="请输入旧密码"
                clearable
              ></el-input>
              <el-input
                v-model="new_password"
                placeholder="新密码"
                clearable
              ></el-input>
            </div>
            <span slot="footer" class="dialog-footer">
              <el-button @click="openDialog = false">取 消</el-button>
              <el-button type="primary" @click="updateUserInfo"
                >确 定</el-button
              >
            </span>
          </el-dialog>
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

<script setup>
import { ref, onMounted, reactive } from "vue";
import OrderItem from "@c/OrderItem.vue";
import ProductItem from "@c/ProductItem.vue";
import {
  getUser,
  logout,
  modify_username,
  modify_address,
  modify_password,
} from "@/api/user.js";
import { showCurrentUserOrders } from "@/api/order.js";
import { showProductsList } from "@/api/product.js";
import { userStore } from "@/store/user.js";
import { useRouter } from "vue-router";
// Lifecycle hook
onMounted(() => {
  createdUserInformation();
  showCurrentUserOrders().then((res) => {
    if (res.success) {
      orders.value = res.data.orders;
    }
  });
  showProductsList().then((res) => {
    if (res.success) {
      products.value = res.data.products;
    } else {
      ElMessage({
        showClose: true,
        message: res.message,
        type: "error",
      });
    }
  });
});

// Reactive state
const loginInfo = reactive({
  phone: "",
  user_name: "",
  buy_address: "",
  gender: "",
  pay_type: "",
});

const showOrders = ref(false);
const showProducts = ref(false);
const store = userStore();
const router = useRouter();

const orders = ref([]);
const products = ref([]);
const openDialog = ref(false);
const new_username = ref("");
const new_address = ref("");
const old_password = ref("");
const new_password = ref("");

// Methods
const toggleOrders = () => {
  showOrders.value = !showOrders.value;
};

const toggleProducts = () => {
  showProducts.value = !showProducts.value;
};

const createdUserInformation = () => {
  getUser(store.getToken)
    .then((res) => {
      console.log(res);
      if (res.success) {
        loginInfo.phone = res.data.phone;
        loginInfo.user_name = res.data.user_name;
        loginInfo.buy_address = res.data.buy_address;
        loginInfo.gender = res.data.gender;
        loginInfo.pay_type = res.data.pay_type;
      } else {
        ElMessage({
          showClose: true,
          message: "获取用户信息失败，请重新登录",
          type: "error",
        });
        router.push("/login");
      }
    })
    .catch((err) => {
      console.log(err);
    });
};

const Logout = () => {
  logout().then((res) => {
    console.log(res);
    if (res.success) {
      ElMessage({
        showClose: true,
        message: "退出登录成功",
        type: "success",
      });
      store.setUserInfo({ token: "" });
      router.push("/");
    }
  });
};

const updateUserInfo = () => {
  // Call API functions here (modify_username and modify_address)
  // Update loginInfo after successful API calls
  // Close the dialog and reset input fields
  openDialog.value = false;
  // Implement actual API calls and update logic
  updateUserAddress();
  updateUserName();
  updateUserPassword();
};

const updateUserName = () => {
  modify_username({
    new_username: new_username.value,
  })
    .then((res) => {
      if (res.success) {
        loginInfo.user_name = new_username.value;
        ElMessage({ message: res.message, type: "success" });
      } else {
        ElMessage({ message: res.message, type: "error" });
      }
    })
    .catch((err) => {
      console.error(err);
    });
};

const updateUserAddress = () => {
  modify_address({ new_address: new_address.value })
    .then((res) => {
      if (res.success) {
        loginInfo.buy_address = new_address.value;
        ElMessage({ message: res.message, type: "success" });
      } else {
        ElMessage({ message: res.message, type: "error" });
      }
    })
    .catch((err) => {
      console.error(err);
    });
};

const updateUserPassword = () => {
  modify_password({
    old_password: old_password.value,
    new_password: new_password.value,
  })
    .then((res) => {
      if (res.success) {
        ElMessage({ message: res.message, type: "success" });
      } else {
        ElMessage({ message: res.message, type: "error" });
      }
    })
    .catch((err) => {
      console.error(err);
    });
};
</script>
