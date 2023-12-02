<template>
  <div
    class="bg-admin-background bg-cover bg-center bg-no-repeat p-4 min-h-screen"
  >
    <div style="position: relative; z-index: 1">
      <personal-center-side-bar />
    </div>
    <div
      class="user-management mx-20 bg-white"
      style="position: relative; z-index: 0"
    >
      <div v-if="userList.length === 0">
        <h1 class="text-2xl text-center">当前没有用户</h1>
      </div>
      <div v-else>
        <h1 class="text-2xl text-center">用户管理</h1>
        <div class="user-container">
          <el-row v-for="(user, index) in userList" :key="index" class="mb-4">
            <!-- User Item -->
            <el-col :span="12">
              <user-info-item
                :avatar="user.avatar"
                :user_name="user.user_name"
                :phone="user.phone"
              />
            </el-col>
          </el-row>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";

const userList = ref([
  {
    avatar: "https://charles2530.github.io/image/background/logo2.jpg",
    user_name: "charles",
    phone: "123456789",
  },
  // Add more users as needed
]);
</script>

<style scoped>
/* Add any additional styling for the User Management page as needed */
.user-management {
  padding: 20px; /* Adjust padding as needed */
}

.user-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}
.user-info-item {
  width: calc(50% - 8px); /* 50% width with some spacing */
  margin-bottom: 16px; /* Add some bottom margin for spacing */
  /* Additional styling based on your design preferences */
}
</style>
