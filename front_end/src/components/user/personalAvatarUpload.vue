<template>
  <el-upload
    ref="uploadRef"
    :action="url"
    method="post"
    :show-file-list="false"
    accept="image/*"
    :on-success="handleAvatarSuccess"
  >
    <el-button
      type="primary"
      size="large"
      class="mt-4 m-12 text-white font-semibold hover:underline"
      plain
    >
      <el-icon class="mr-4"><Camera /></el-icon>
      上传头像</el-button
    >
  </el-upload>
</template>
<script>
import { ref, reactive } from "vue";
import { userStore } from "@/store/user.js";
import { ElMessage } from "element-plus";
export default {
  name: "personalAvatarUpload",
  setup() {
    const store = userStore();
    const uploadRef = ref(null);
    const url =
      import.meta.env.VITE_APP_BASE_API +
      //   "http://127.0.0.1:3000/api" +
      "/users/" +
      store.getToken +
      "/upload_avatar";
    const upload = () => {
      uploadRef.value.submit();
    };
    const handleAvatarSuccess = (res) => {
      if (res.success) {
        ElMessage({
          message: "上传成功",
          type: "success",
        });
        window.location.reload();
      } else {
        ElMessage({
          message: res.message,
          type: "error",
        });
      }
    };
    return {
      uploadRef,
      url,
      upload,
      handleAvatarSuccess,
    };
  },
};
</script>
