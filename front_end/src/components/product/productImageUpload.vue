<template>
  <el-upload
    ref="uploadRef"
    :action="url"
    method="post"
    :show-file-list="false"
    accept="image/*"
    :on-success="handleAvatarSuccess"
  >
    <el-button type="primary" plain>
      <el-icon class="mr-4"><Camera /></el-icon>
      上传商品图片</el-button
    >
  </el-upload>
</template>
<script>
import { ref } from "vue";
import { userStore } from "@/store/user.js";
import { ElMessage } from "element-plus";
export default {
  name: "productImageUpload",
  setup() {
    const uploadRef = ref(null);
    const url = import.meta.env.VITE_APP_BASE_API + "/upload_image";
    const uploadedImageUrl = ref("");
    const upload = () => {
      uploadRef.value.submit();
    };
    const handleAvatarSuccess = (res) => {
      if (res.success) {
        ElMessage({
          message: "上传成功",
          type: "success",
        });
        uploadedImageUrl.value = res.data.image_url;
        const imageUrl = uploadedImageUrl.value;
        emit("image-uploaded", imageUrl);
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
