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
    <el-button type="primary" plain>
      <el-icon v-if="!uploading" class="mr-4"><Camera /></el-icon>
      <el-icon v-else class="mr-4"><Loading /></el-icon>
      {{ uploading ? "上传中..." : "上传商品图片" }}</el-button
    >
  </el-upload>
</template>
<script>
import { ref } from "vue";
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
      uploading,
      beforeUpload,
    };
  },
};
</script>
