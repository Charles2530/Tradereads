<template>
  <div class="min-h-screen bg-gray-100 p-4">
    <div class="container mx-auto">
      <h1 class="text-2xl font-bold text-gray-800 mb-4">开发者模式</h1>

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

      <!-- 提交测试日志功能板块 -->
      <div class="bg-white shadow-md rounded p-4">
        <h2 class="text-2xl font-semibold mb-3">提交测试日志</h2>
        <div class="mb-4">
          <label class="block mb-2 text-xl">
            日志内容:
            <textarea
              v-model="logText"
              class="block w-full border-gray-300 rounded-md p-2 transition border focus:border-blue-500"
              rows="8"
            ></textarea>
          </label>
        </div>

        <button
          @click="submitLog"
          class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        >
          提交日志
        </button>
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
