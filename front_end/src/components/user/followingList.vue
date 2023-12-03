<template>
  <div class="following-list">
    <div v-if="followingList.length === 0">
      <h1 class="text-2xl text-center">你还没有关注别的用户，快去关注吧</h1>
    </div>
    <div v-else>
      <h1 class="text-2xl text-center">Following List</h1>
      <div
        class="bg-gray-600/80 p-4 rounded-lg shadow-md following-container"
      ></div>
      <el-row v-for="(user, index) in followingList" :key="index" class="mb-4">
        <!-- User Item -->
        <user-info-item
          :avatar="user.avatar"
          :user_name="user.user_name"
          :phone="user.phone"
        />
      </el-row>
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

.user-info-item {
  width: calc(50% - 8px); /* 50% width with some spacing */
  margin-bottom: 16px; /* Add some bottom margin for spacing */
  /* Additional styling based on your design preferences */
}
</style>
