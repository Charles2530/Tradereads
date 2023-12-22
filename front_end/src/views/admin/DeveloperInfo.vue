<template>
  <div class="min-h-screen bg-gray-100">
    <navigation-bar />
    <div
      class="bg-developer-background bg-cover bg-center bg-no-repeat p-4 min-h-screen pl-12"
    >
      <div style="position: relative; z-index: 1">
        <personal-center-side-bar />
      </div>
      <div class="container mx-auto" style="position: relative; z-index: 0">
        <h1 class="text-4xl font-bold text-white mb-4 flex justify-center">
          客服中心
        </h1>

        <!-- 提交测试日志功能板块 -->
        <div class="bg-white shadow-md rounded p-4">
          <h2 class="text-2xl font-semibold mb-3">提交建议</h2>
          <p class="my-2 text-gray-400">
            在这里你可以提交对我们系统的反馈或者建议!
          </p>
          <p class="my-2 text-gray-400">在这里你也可以提交对某些商家的投诉!</p>
          <div class="mb-4">
            <label class="block mb-2 text-xl">
              建议内容:
              <textarea
                v-model="logText"
                class="block w-full border-gray-300 rounded-md p-2 transition border focus:border-blue-500"
                rows="8"
              ></textarea>
            </label>
          </div>
          <el-button type="primary" @click="submitLog" plain>
            <el-icon class="mr-3"><FolderRemove /></el-icon>
            提交日志
          </el-button>
        </div>
        <!-- 开发者信息板块 -->
        <div class="mb-6">
          <div class="bg-white shadow-md rounded p-4">
            <h2 class="text-2xl font-semibold mb-3 flex justify-center">
              开发者信息
            </h2>
            <div>
              <!-- 开发者信息内容 -->
              <p class="mb-2 text-xl"><strong>开发者1：</strong> 杜金阳</p>
              <p class="mb-2 text-xl"><strong>开发者2：</strong> 黄泓亮</p>
              <p class="mb-2 text-xl"><strong>开发者3：</strong> 叶锦轩</p>
              <!-- 添加更多开发者信息 -->
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ElMessage } from "element-plus";
export default {
  data() {
    return {
      logText: "",
    };
  },
  methods: {
    submitLog() {
      if (this.logText.trim() !== "") {
        console.log("提交日志内容:", this.logText);
        this.logText = "";
        ElMessage({
          showClose: true,
          type: "success",
          message: "日志提交成功",
        });
      } else {
        ElMessage({
          showClose: true,
          type: "error",
          message: "日志内容不能为空",
        });
      }
    },
  },
};
</script>
