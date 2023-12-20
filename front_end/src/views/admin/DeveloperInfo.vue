<template>
  <div class="min-h-screen bg-gray-100 p-4">
    <div class="container mx-auto">
      <h1 class="text-2xl font-bold text-gray-800 mb-4">开发者模式</h1>
      <div class="bg-white shadow-md rounded p-4">
        <h2 class="text-xl font-semibold mb-3">系统日志</h2>
        <div class="overflow-auto h-64 mb-4 p-2 bg-gray-200">
          <!-- 日志输出 -->
          <pre>{{ systemLogs }}</pre>
        </div>

        <h2 class="text-xl font-semibold mb-3">功能测试</h2>
        <button
          @click="testFunction"
          class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        >
          执行测试
        </button>

        <h2 class="mt-6 text-xl font-semibold mb-3">配置设置</h2>
        <div>
          <!-- 配置选项 -->
          <label class="block mb-2">
            <input
              type="checkbox"
              v-model="configOptions.debugMode"
              class="mr-2"
            />
            调试模式
          </label>
          <!-- 更多配置 -->
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";

const systemLogs = ref("这里将显示系统日志...");
const configOptions = ref({
  debugMode: false,
  // 其他配置选项
});

const testFunction = () => {
  systemLogs.value = "执行了测试功能...";
  // 实现测试功能的逻辑
};
</script>

<style scoped>
/* Tailwind CSS 样式 */
</style>
