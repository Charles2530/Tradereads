<template>
  <el-upload
    ref="uploadRef"
    :action="url"
    method="post"
    :show-file-list="false"
    accept="image/*"
    :on-success="handleAvatarSuccess"
    :before-upload="beforeUpload"
  >
    <el-button
      type="primary"
      size="large"
      class="mt-4 m-12 text-white font-semibold hover:underline"
      plain
    >
      <el-icon v-if="!uploading" class="mr-4"><Camera /></el-icon>
      <el-icon v-else class="mr-4"><Loading /></el-icon>
      {{ uploading ? "上传中..." : "上传头像" }}
    </el-button>
  </el-upload>
</template>
<script>
import { ref } from "vue";
import { userStore } from "@/store/user.js";
import { ElMessage } from "element-plus";
export default {
  name: "personalAvatarUpload",
  setup() {
    const store = userStore();
    const uploadRef = ref(null);
    const url =
      import.meta.env.VITE_APP_BASE_API +
      "/users/" +
      store.getToken +
      "/upload_avatar";
    const upload = () => {
      uploadRef.value.submit();
    };
    let uploading = false;
    const beforeUpload = () => {
      uploading = true;
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
      beforeUpload,
      handleAvatarSuccess,
      uploading,
    };
  },
};
</script>
