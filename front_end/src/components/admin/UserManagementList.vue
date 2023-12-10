<template>
  <div v-if="userList.length === 0">
    <h1 class="text-2xl text-center">当前没有用户</h1>
  </div>
  <div v-else>
    <h1 class="text-4xl font-bold mb-8 flex justify-center">用户管理</h1>
    <div
      class="bg-gray-600/80 p-1 rounded-lg shadow-md following-container mb-2"
    ></div>
    <div class="user-container">
      <el-row v-for="(user, index) in userListPerPage" :key="index">
        <!-- User Item -->
        <el-col :span="24">
          <el-scrollbar max-height="500px">
            <user-manage-item
              :user_id="user.user_id"
              :user_name="user.user_name"
              :phone="user.user_phone"
            />
          </el-scrollbar>
        </el-col>
        <el-col>
          <div
            class="bg-gray-600/80 p-1 rounded-lg shadow-md following-container mt-1 mb-1"
          ></div>
        </el-col>
      </el-row>
    </div>
    <!-- Add pagination below the user list -->
    <el-pagination
      :current-page="currentPage"
      :page-size="pageSize"
      :total="userList.length"
      @current-change="handlePageChange"
    />
  </div>
</template>

<script>
import { computed, ref } from "vue";
export default {
  name: "UserManagementList",
  props: {
    userList: {
      type: Array,
      required: true,
    },
  },
  setup(props) {
    const pageSize = ref(5);
    const currentPage = ref(1);
    const userListPerPage = computed(() => {
      const start = (currentPage.value - 1) * pageSize.value;
      const end = currentPage.value * pageSize.value;
      return props.userList.slice(start, end);
    });

    const handlePageChange = (newPage) => {
      currentPage.value = newPage;
    };

    return {
      pageSize,
      currentPage,
      handlePageChange,
      userListPerPage,
    };
  },
};
</script>

<style scoped>
.user-info-item {
  width: calc(50% - 8px); /* 50% width with some spacing */
  margin-bottom: 16px; /* Add some bottom margin for spacing */
}
</style>
