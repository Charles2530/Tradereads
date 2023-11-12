<template>
  <div
    class="min-h-screen bg-login-background bg-cover bg-center bg-no-repeat flex justify-end items-center p-10"
  >
    <div class="w-full max-w-xs bg-white p-8 rounded shadow-lg">
      <h1
        class="register__title text-2xl font-bold mb-6 bg-blue-500 text-white p-3 rounded text-center"
      >
        注册用户<el-icon class="text-cyan-400"><User /></el-icon>
      </h1>
      <form class="register__form space-y-4">
        <div class="register__text mb-4">
          <el-input
            class="w-full p-2 border rounded border-gray-300 focus:outline-none focus:border-blue-500"
            v-model="username"
            placeholder="Username"
            clearable
          />
        </div>
        <div class="register__password mb-4">
          <el-input
            v-model="password"
            class="w-full p-2 border rounded border-gray-300 focus:outline-none focus:border-blue-500"
            type="password"
            placeholder="Password"
            show-password
          />
        </div>
        <div class="register__email mb-4">
          <el-input
            v-model="email"
            class="w-full p-2 border rounded border-gray-300 focus:outline-none focus:border-blue-500"
            type="email"
            placeholder="Email"
            clearable
          />
        </div>
        <div class="register__button">
          <button
            type="submit"
            class="w-full bg-blue-500 text-white p-2 rounded hover:bg-blue-600 focus:outline-none focus:border-blue-700 focus:ring focus:ring-blue-200"
            @click.prevent="register"
            @click="open"
          >
            register
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";
import { userStore } from "@/store/user.js"; // Make sure the path is correct
import { useRouter } from "vue-router";

export default {
  setup() {
    // Reactive state properties
    const username = ref("");
    const password = ref("");
    const email = ref(""); // Initialize with an empty string or fetch from the store

    // Store and Router instances
    const store = userStore();
    const router = useRouter();

    // If email should be initialized from the store, you can do so after store initialization
    email.value = store.$state.userInfo.email; // Assuming store.state.userInfo.email is reactive

    // Login method
    const register = () => {
      store.setUserInfo({
        token: "123456789",
        userInfo: {
          username: username.value,
          password: password.value,
          email: email.value,
        },
      });

      // Redirect after setting user info
      router.push("/personalCenter");
    };

    // Open notification
    const open = () => {
      ElMessage({
        showClose: true,
        message: "注册成功",
        type: "success",
      });
    };

    // Return the reactive state and methods to the template
    return {
      username,
      password,
      email,
      register,
      open,
    };
  },
};
</script>
