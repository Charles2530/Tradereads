<template>
  <div>
    <el-menu
      class="el-menu-vertical-demo rounded-lg"
      :default-active="activeMenu"
      background-color="#fff"
      text-color="#000"
      active-text-color="#ffd04b"
    >
      <div>
        <logo-info></logo-info>
      </div>
      <el-sub-menu index="1">
        <template #title>
          <el-icon class="el-icon-menu"><Menu></Menu></el-icon>
          <strong class="nav-title text-md">网站导航</strong>
        </template>
        <div class="item_container px-5">
          <el-menu-item index="1">
            <i class="el-icon-style">
              <HomeFilled />
            </i>
            <router-link class="nav-title" to="/personalCenter"
              >个人中心</router-link
            >
          </el-menu-item>
          <el-menu-item index="2">
            <i class="el-icon-style">
              <Goods></Goods>
            </i>
            <router-link class="nav-title" to="/ProductBuy"
              >商品中心</router-link
            >
          </el-menu-item>
          <el-menu-item index="3">
            <i class="el-icon-style">
              <Ticket></Ticket>
            </i>
            <router-link class="nav-title" to="/shopping"
              >我的购物车</router-link
            >
          </el-menu-item>
          <el-menu-item index="4">
            <i class="el-icon-style"><TrendCharts /></i>
            <router-link class="nav-title" to="/rankingList"
              >排行榜</router-link
            >
          </el-menu-item>
          <el-menu-item index="5">
            <i class="el-icon-style"><Setting /></i>
            <router-link class="nav-title" to="/DeveloperInfo"
              >客服中心</router-link
            >
          </el-menu-item>
        </div>
      </el-sub-menu>
      <div v-if="adminMode">
        <el-sub-menu index="2">
          <template #title>
            <el-icon class="el-icon-menu"><Monitor /></el-icon>
            <strong class="nav-title text-md">管理员模式</strong>
          </template>
          <div class="item_container px-5">
            <el-menu-item index="6">
              <i class="el-icon-style">
                <Document></Document>
              </i>
              <router-link class="nav-title" to="/ordersManagement"
                >订单管理</router-link
              >
            </el-menu-item>
            <el-menu-item index="7">
              <i class="el-icon-style">
                <Service />
              </i>
              <router-link class="nav-title" to="/checkOrdersView"
                >审核商品</router-link
              >
            </el-menu-item>
            <el-menu-item index="8">
              <i class="el-icon-style">
                <List />
              </i>
              <router-link class="nav-title" to="/usersManagement"
                >用户管理</router-link
              >
            </el-menu-item>
          </div>
        </el-sub-menu>
      </div>
      <el-menu-item index="9">
        <template #title>
          <el-icon class="el-icon-notice">
            <BellFilled />
          </el-icon>
          <button @click="GoNotice" class="nav-title">
            <strong class="nav-title text-md">公告栏</strong>
          </button>
        </template>
      </el-menu-item>
      <el-menu-item index="10">
        <template #title>
          <el-icon class="el-icon-location"><Location /></el-icon>
          <button @click="Logout" class="nav-title">
            <strong class="nav-title text-md">退出登录</strong>
          </button>
        </template>
      </el-menu-item>
    </el-menu>
  </div>
</template>

<script>
import { ref } from "vue";
import { ElMessage, ElMenu, ElMenuItem, ElSubMenu } from "element-plus";
import { logout } from "@/api/user.js";
import { userStore } from "@/store/user.js";
import { useRouter } from "vue-router";
export default {
  name: "personalCenterSideBar",
  components: { ElMenu, ElMenuItem, ElSubMenu },
  setup() {
    const activeMenu = ref("0");
    const store = userStore();
    const router = useRouter();
    const adminMode = store.getRight == 1;
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
    const GoNotice = () => {
      router.push("/notice");
    };
    return {
      adminMode,
      activeMenu,
      Logout,
      GoNotice,
    };
  },
};
</script>

<style scoped>
.el-menu-vertical-demo {
  width: 60px;
  height: 100%;
  position: fixed;
  top: 0;
  left: 0;
  background-color: #fff;
  overflow: hidden;
  transition: width 0.3s ease;
}
.el-menu-vertical-demo .el-sub-menu {
  width: 250px; /* Set the width of the submenu to match the collapsed state */
}
.el-menu-vertical-demo:hover {
  width: 250px; /* Set the width to the expanded state on hover */
}
.el-icon-menu,
.el-icon-notice,
.el-icon-location {
  margin-right: 20px;
  color: red;
}
.nav-title:hover {
  text-decoration: underline;
  cursor: pointer;
  transform: scale(1.05);
  transition: all 0.2s ease-in-out;
  color: red;
}
.el-icon-style {
  font-size: 20px;
  margin-right: 20px;
}
.nav-title {
  color: #666;
  padding-left: 3px;
  font-style: normal !important;
}
</style>
