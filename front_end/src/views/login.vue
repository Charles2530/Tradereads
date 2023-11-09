<!-- <template>
  <div class="login">
    <div
      class="login__container p-8 bg-white rounded shadow-lg max-w-md w-full"
    >
      <h1 class="login__title text-2xl font-bold mb-6 bg-black">Login</h1>
      <form class="login__form">
        <div class="login__text mb-4">
          <input
            type="text"
            placeholder="Username"
            class="w-full p-2 border rounded border-gray-300 focus:outline-none focus:border-blue-500"
          />
        </div>
        <div class="login__password mb-4">
          <input
            type="password"
            placeholder="Password"
            class="w-full p-2 border rounded border-gray-300 focus:outline-none focus:border-blue-500"
          />
        </div>
        <div class="login__button">
          <button
            type="submit"
            class="w-full bg-blue-500 text-white p-2 rounded hover:bg-blue-600 focus:outline-none focus:border-blue-700 focus:ring focus:ring-blue-200"
          >
            Login
          </button>
        </div>
      </form>
    </div>
  </div>
</template> -->
<template>
  <el-input v-model="input" placeholder="Please input" />
</template>

<script>
import { ref } from "vue";
export default {
  setup() {
    const input = ref("");
    return {
      input,
    };
  },
};
</script>
