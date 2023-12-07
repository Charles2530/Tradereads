<template>
  <div class="following-list">
    <div v-if="followingList.length === 0">
      <h1 class="text-2xl text-center">你还没有关注别的用户，快去关注吧</h1>
    </div>
    <div v-else>
      <h1 class="text-3xl text-center mb-4">关注列表</h1>
      <div
        class="bg-gray-600/80 p-1 rounded-lg shadow-md following-container"
      ></div>
      <div>
        <el-row v-for="(user, index) in followingList" :key="index">
          <!-- User Item -->
          <el-col :span="24">
            <follow-info-item
              :user_id="user.following_user_id"
              :user_name="user.following_user_name"
            />
          </el-col>
          <el-col>
            <div
              class="bg-gray-600/80 p-1 rounded-lg shadow-md following-container"
            ></div>
          </el-col>
        </el-row>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "followingList",
  props: {
    followingList: {
      type: Array,
      default: () => [
        {
          avatar: "https://charles2530.github.io/image/background/logo2.jpg",
          user_name: "charles",
          phone: "123456789",
        },
      ],
    },
  },
};
</script>

<style scoped>
/* Add any additional styling for the Following List page as needed */
.following-list {
  padding: 20px; /* Adjust padding as needed */
}
.following-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}

.follow-info-item {
  width: calc(50% - 8px); /* 50% width with some spacing */
  margin-bottom: 16px; /* Add some bottom margin for spacing */
  /* Additional styling based on your design preferences */
}
</style>
