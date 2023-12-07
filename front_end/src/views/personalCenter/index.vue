<template>
  <div>
    <navigation-bar></navigation-bar>
    <div
      class="bg-personalCenter-background bg-cover bg-center bg-no-repeat p-4 min-h-screen"
    >
      <el-row>
        <el-col :span="5">
          <div
            class="headBar ml-100 bg-gradient-to-r from-blue-400/70 to-red-500/70 rounded-lg shadow-md p-4"
          >
            <personal-mode></personal-mode>
          </div>
        </el-col>
        <el-col :span="19"
          ><div
            class="headBar ml-100 bg-gradient-to-r from-blue-400/70 to-red-500/70 rounded-lg shadow-md p-4"
          >
            <personal-info></personal-info></div
        ></el-col>
      </el-row>
    </div>
    <div>
      <personal-center-side-bar></personal-center-side-bar>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import personalCenterSideBar from "@c/user/personalCenterSideBar.vue";
import personalInfo from "@c/user/personalInfo.vue";
import { showCurrentUserOrders } from "@/api/order.js";
import { showProductsList } from "@/api/product.js";
import { userStore } from "@/store/user.js";
import NavigationBar from "@c/home/NavigationBar.vue";
// Lifecycle hook
onMounted(() => {
  showCurrentUserOrders().then((res) => {
    if (res.success) {
      console.log(res.data.orders);
      orders.value = res.data.orders;
    }
  });

  showProductsList(store.getToken).then((res) => {
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

const store = userStore();
const orders = ref([]);
const products = ref([]);
</script>
