<template>
  <el-menu
    class="el-menu-vertical-demo"
    :default-active="activeMenu"
    background-color="#fff"
    text-color="#000"
    active-text-color="#ffd04b"
  >
    <el-sub-menu index="5">
      <template #title>
        <el-icon>
          <Menu></Menu>
        </el-icon>
        <router-link to="/personalCenter">网站导航</router-link>
      </template>
      <!-- Add more menu items here if needed -->
      <el-menu-item index="1">
        <i class="el-icon-user">
          <User></User>
        </i>
        <router-link to="/personalCenter">订单信息</router-link>
      </el-menu-item>
      <el-menu-item index="2">
        <i class="el-icon-tickets">
          <Ticket></Ticket>
        </i>
        <router-link to="/shopping">我的购物车</router-link>
      </el-menu-item>
      <el-menu-item index="3">
        <i class="el-icon-goods">
          <Goods></Goods>
        </i>
        <router-link to="/ProductBuy">商品中心</router-link>
      </el-menu-item>
      <!-- <el-menu-item index="4">
      <i class="el-icon-setting"></i>
      <router-link to="/MyItem">我的商品</router-link>
    </el-menu-item> -->
      <el-menu-item index="5" @click="showAllOrderList">
        <i class="el-icon-document">
          <Document></Document>
        </i>
        <router-link to="/personalCenter">查看所有订单</router-link>
      </el-menu-item>
      <el-dialog title="查看所有订单" v-model="openOrderLists" width="90%">
        <h2 class="text-white text-2xl font-semibold mb-4">订单列表</h2>
        <div class="bg-gray-600/80 p-4 rounded-lg shadow-md">
          <order-item
            v-for="order in all_orders"
            :key="order.order_id"
            :buyer_id="order.buyer_id"
            :order_id="order.order_id"
            :total_price="order.total_price"
            :order_time="order.order_time"
            :items="order.items"
          ></order-item>
        </div>
      </el-dialog>
    </el-sub-menu>
  </el-menu>
</template>

<script>
import { ref } from "vue";
import { ElMessage, ElMenu, ElMenuItem, ElSubMenu } from "element-plus";
import { showAllOrders } from "@/api/order";

const openOrderLists = ref(false);
const all_orders = ref([]);
const activeMenu = ref("1");
const showAllOrderList = () => {
  showAllOrders().then((res) => {
    if (res.success) {
      console.log(res.data.orders);
      all_orders.value = res.data.orders;
      openOrderLists.value = true;
    } else {
      ElMessage({
        showClose: true,
        message: res.message,
        type: "error",
      });
    }
  });
};
export default {
  name: "personalCenterSideBar",
  components: { ElMenu, ElMenuItem, ElSubMenu },
  setup() {
    return { activeMenu, openOrderLists, all_orders, showAllOrderList };
  },
};
</script>

<style scoped>
.el-menu-vertical-demo {
  width: 200px;
  height: 100%;
  position: fixed;
  top: 0;
  left: 0;
  background-color: #fff;
}
.el-icon-menu {
  margin-right: 10px;
  color: red;
}
</style>
