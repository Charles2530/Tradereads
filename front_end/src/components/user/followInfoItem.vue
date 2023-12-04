<template>
  <div>
    <el-row class="following-item">
      <!-- Left section: Avatar -->
      <el-col :span="2">
        <img :src="avatar" alt="Avatar" class="avatar-img mx-4 mt-2" />
      </el-col>
      <el-col :span="1"></el-col>

      <!-- Middle section: Vertical line -->
      <el-col :span="1">
        <div class="vertical-line"></div>
      </el-col>

      <!-- Right section: User information -->
      <el-col :span="8">
        <div class="user-info-section">
          <div class="user-name text-xl">
            <strong>用户名:</strong>{{ user_name }}
          </div>
          <div class="phone-number text-xl">
            <strong>电话号码:</strong>{{ phone }}
          </div>
        </div>
      </el-col>
      <el-col :span="8">
        <div class="float-right">
          <div class="mt-2 mb-2">
            <el-button
              type="danger"
              class="text-white font-semibold hover:underline"
              @click="deleteUser"
              plain
            >
              <el-icon class="ml-1 mr-4"><Operation /></el-icon>

              取消关注</el-button
            >
          </div>
          <div>
            <el-button
              type="success"
              class="text-white font-semibold hover:underline"
              @click="goDetails"
              plain
            >
              <el-icon class="ml-1 mr-4"><Share /></el-icon>
              查看主页</el-button
            >
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { getUser } from "@/api/user.js";
import { ref } from "vue";
export default {
  name: "followInfoItem",
  props: {
    user_id: {
      type: Number,
      default: 1,
    },
    user_name: {
      type: String,
      default: "charles",
    },
  },
  setup(props) {
    const avatar = ref("");
    const phone = ref("");
    getUser(props.user_id).then((res) => {
      if (res.success) {
        console.log(res.data);
        avatar.value = res.data.avatar;
        phone.value = res.data.phone;
      }
    });
    return {
      avatar,
      phone,
    };
  },
};
</script>

<style scoped>
.following-item {
  margin-bottom: 16px;
  width: 100%;
}
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
  width: 100%;
  justify-content: center;
  padding-left: 16px; /* Adjust padding as needed */
}

.user-name,
.phone-number {
  font-size: 18px; /* Adjust font size as needed */
  margin-bottom: 8px; /* Add some spacing between lines */
  color: #000;
}
.el-row {
  margin-bottom: 16px;
  width: 100%;
}

/* Additional styling based on your design preferences */
</style>
