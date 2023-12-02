<template>
  <div class="following-item">
    <el-row>
      <!-- Left section: Avatar -->
      <el-col :span="8">
        <img :src="avatar" alt="Avatar" class="avatar-img" />
      </el-col>
      <el-col :span="1"></el-col>

      <!-- Middle section: Vertical line -->
      <el-col :span="1">
        <div class="vertical-line"></div>
      </el-col>

      <!-- Right section: User information -->
      <el-col :span="14">
        <div class="user-info-section">
          <div class="user-name text-xl">
            {{ user_name }}
          </div>
        </div>
      </el-col>
    </el-row>
    <el-divider></el-divider>
  </div>
</template>

<script>
export default {
  name: "userInfoItem",
  props: {
    avatar: {
      type: String,
      default: "https://charles2530.github.io/image/background/logo2.jpg",
    },
    user_name: {
      type: String,
      default: "charles",
    },
  },
};
</script>

<style scoped>
.vertical-line {
  height: 100%; /* Adjust height to match the avatar */
  width: 1px; /* Adjust width as needed */
  background-color: #000; /* Line color */
}

.avatar-img {
  width: inherit; /* Make the image fill the container */
  height: inherit; /* Make the image fill the container */
  border-radius: 50%; /* Make it circular */
}

.user-info-section {
  display: flex;
  flex-direction: column;
  height: 100%;
  justify-content: center;
  padding-left: 16px; /* Adjust padding as needed */
}

.user-name {
  font-size: 18px; /* Adjust font size as needed */
  margin-bottom: 8px; /* Add some spacing between lines */
  color: #fff;
}

/* Additional styling based on your design preferences */
</style>
