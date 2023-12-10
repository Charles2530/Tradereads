<template>
  <div v-if="userList.length === 0">
    <h1 class="text-2xl text-center">当前没有用户</h1>
  </div>
  <div v-else>
    <h1 class="text-4xl font-bold mb-8 flex justify-center">用户管理</h1>
    <div class="flex justify-end mb-4">
      <el-select
        v-model="searchType"
        placeholder="搜索维度"
        style="width: 150px; margin-right: 10px"
      >
        <el-option label="用户名" value="user_name"></el-option>
        <el-option label="电话号码" value="user_phone"></el-option>
      </el-select>
      <el-input
        v-model="searchKeyword"
        placeholder="关键词"
        style="width: 150px; margin-right: 10px"
      ></el-input>
      <div>
        <el-switch
          class="mx-4 mb-2"
          v-model="Match"
          style="--el-switch-on-color: #13ce66; --el-switch-off-color: #ff4949"
          active-text="模糊匹配"
          :active-action-icon="View"
          :inactive-action-icon="Hide"
        />
      </div>
    </div>
    <div
      class="bg-gray-600/80 p-1 rounded-lg shadow-md following-container mb-2"
    ></div>

    <div class="user-container">
      <el-row v-for="(user, index) in userListPerPage" :key="index">
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
    <el-pagination
      :current-page="currentPage"
      :page-size="pageSize"
      :total="filteredUserList.length"
      @current-change="handlePageChange"
    />
  </div>
</template>

<script>
import { computed, ref, watch } from "vue";
import { Hide, View } from "@element-plus/icons-vue";
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
    const searchType = ref("user_name");
    const searchKeyword = ref("");
    const Match = ref(false);
    const filteredUserList = computed(() => {
      const filteredList = props.userList.filter((user) => {
        const fieldValue = user[searchType.value];
        if (!Match.value) {
          return !searchKeyword.value || fieldValue == searchKeyword.value;
        }
        return !searchKeyword.value || fieldValue.includes(searchKeyword.value);
      });
      return filteredList;
    });

    const searchUsers = () => {
      currentPage.value = 1;
    };
    watch(searchKeyword, searchUsers);
    watch(searchType, searchUsers);

    const userListPerPage = computed(() => {
      const start = (currentPage.value - 1) * pageSize.value;
      const end = currentPage.value * pageSize.value;
      return filteredUserList.value.slice(start, end);
    });

    const handlePageChange = (newPage) => {
      currentPage.value = newPage;
    };

    return {
      pageSize,
      currentPage,
      handlePageChange,
      userListPerPage,
      searchUsers,
      filteredUserList,
      searchKeyword,
      searchType,
      Hide,
      View,
      Match,
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
