<template>
  <div class="logo-container">
    <el-row>
      <el-col :span="8"
        ><img
          ref="logo"
          src="@/assets/img/logo_blank.jpg"
          alt="Logo"
          class="h-10 w-12 mr-2 mt-2 float-left"
      /></el-col>
      <el-col :span="16"
        ><h3 class="text-lg font-semibold ml-4 mr-16 mt-4 website-name">
          {{ websiteName }}
        </h3>
      </el-col>
    </el-row>
  </div>
  <el-divider></el-divider>
</template>

<script>
export default {
  setup() {
    // 网站名称
    const websiteName = "Tradereads";
    return {
      websiteName,
    };
  },
};
</script>

<style scoped>
.logo-container {
  padding: 0 0 0 0;
  width: 250px;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}
.logo {
  border: 2px solid #000;
  border-radius: 50%;
}

.logo:hover {
  transform: scale(1.1);
  opacity: 0.8;
}

.website-name {
  color: #ff7e5f; /* 文本颜色 */
  transition: color 0.3s ease-in-out; /* 添加过渡效果 */
}

.website-name:hover {
  color: #6cb2eb; /* 悬停时改变文本颜色 */
}
</style>
