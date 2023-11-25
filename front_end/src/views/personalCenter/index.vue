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
          <el-card class="box-card">
            <el-row>
              <el-col :span="12">
                <div class="user text-xl">
                  <strong>用户名:</strong> {{ loginInfo.user_name }}
                </div>
                <div class="phone text-xl">
                  <strong>用户电话:</strong> {{ loginInfo.phone }}
                </div>
                <div class="address text-xl">
                  <strong>用户地址:</strong> {{ loginInfo.buy_address }}
                </div>
              </el-col>
              <el-col :span="12">
                <div class="gender text-xl">
                  <strong>性别:</strong> {{ loginInfo.gender }}
                </div>
                <div class="pay_type text-xl">
                  <strong>支付方式:</strong> {{ loginInfo.pay_type }}
                </div>
              </el-col>
            </el-row>
          </el-card>
        </div>
        <!-- 修改个人信息弹窗 -->
        <div>
          <div class="mb-4">
            <el-button
              type="info"
              class="text-white font-semibold hover:underline"
              @click="openUserInformation = true"
              plain
            >
              修改个人信息
            </el-button>
          </div>
          <el-dialog
            title="修改个人信息"
            v-model="openUserInformation"
            width="30%"
          >
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
            </div>
            <span slot="footer" class="dialog-footer">
              <el-button @click="openUserInformation = false">取 消</el-button>
              <el-button type="primary" @click="updateUserInfo"
                >确 定</el-button
              >
            </span>
          </el-dialog>
        </div>
        <!-- 修改用户密码弹窗 -->
        <div class="mb-4">
          <el-button
            type="warning"
            class="text-white font-semibold hover:underline"
            @click="openUserPassword = true"
            plain
          >
            修改用户密码
          </el-button>
        </div>
        <el-dialog title="修改用户密码" v-model="openUserPassword" width="30%">
          <div>
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
            <el-button @click="openUserPassword = false">取 消</el-button>
            <el-button type="primary" @click="updateUserPasswordInfo"
              >确 定</el-button
            >
          </span>
        </el-dialog>
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
              :key="order.order_id"
              :order_id="order.order_id"
              :total_price="order.total_price"
              :order_time="order.order_time"
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
              :key="product.product_id"
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
      console.log(res.data.orders);
      orders.value = res.data.orders;
    }
  });

  showProductsList(store.getToken).then((res) => {
    if (res.success) {
      console.log(store.getToken);
      console.log(res.data.products);
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
const openUserInformation = ref(false);
const openUserPassword = ref(false);
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
      store.clearUserInfo();
      router.push("/");
    }
  });
};

const updateUserInfo = () => {
  // Call API functions here (modify_username and modify_address)
  // Update loginInfo after successful API calls
  // Close the dialog and reset input fields
  openUserInformation.value = false;
  // Implement actual API calls and update logic
  updateUserAddress();
  updateUserName();
};
const updateUserPasswordInfo = () => {
  openUserPassword.value = false;
  updateUserPassword();
};

const updateUserName = () => {
  modify_username({
    user_id: store.getToken,
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
  modify_address({
    user_id: store.getToken,
    new_address: new_address.value,
  })
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
    user_id: store.getToken,
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

<style scoped>
.box-card {
  margin-bottom: 20px;
  border-radius: 10px;
}
</style>
