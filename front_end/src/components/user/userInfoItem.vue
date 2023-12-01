<template>
  <div>
    <el-row class="following-item">
      <!-- Left section: Avatar -->
      <el-col :span="6">
        <img :src="avatar" alt="Avatar" class="avatar-img" />
      </el-col>
      <el-col :span="1"></el-col>

      <!-- Middle section: Vertical line -->
      <el-col :span="1">
        <div class="vertical-line"></div>
      </el-col>

      <!-- Right section: User information -->
      <el-col :span="16">
        <div class="user-info-section">
          <div class="user-name text-xl">
            <strong>用户名:</strong>{{ user_name }}
          </div>
          <div class="phone-number text-xl">
            <strong>电话号码:</strong>{{ phone }}
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  name: "followingItem",
  props: {
    avatar: {
      type: String,
      default: "https://charles2530.github.io/image/background/logo2.jpg",
    },
    user_name: {
      type: String,
      default: "charles",
    },
    phone: {
      type: String,
      default: "123456789",
    },
  },
  setup(props) {
    return {};
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
  width: 100%; /* Make the image fill the container */
  height: 100%; /* Make the image fill the container */
  border-radius: 50%; /* Make it circular */
}

.user-info-section {
  display: flex;
  flex-direction: column;
  height: 100%;
  justify-content: center;
  padding-left: 16px; /* Adjust padding as needed */
}

.user-name,
.phone-number {
  font-size: 18px; /* Adjust font size as needed */
  margin-bottom: 8px; /* Add some spacing between lines */
  color: #fff;
}

/* Additional styling based on your design preferences */
</style>
