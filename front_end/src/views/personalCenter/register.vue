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
            v-model="user_name"
            placeholder="user_name"
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
        <div class="register__phone mb-4">
          <el-input
            v-model="phone"
            class="w-full p-2 border rounded border-gray-300 focus:outline-none focus:border-blue-500"
            type="phone"
            placeholder="phone"
            clearable
          />
        </div>
        <div class="register__gender mb-4">
          <el-input
            v-model="gender"
            class="w-full p-2 border rounded border-gray-300 focus:outline-none focus:border-blue-500"
            type="gender"
            placeholder="gender"
            clearable
          />
        </div>
        <div class="register__button">
          <button
            type="submit"
            class="w-full bg-blue-500 text-white p-2 rounded hover:bg-blue-600 focus:outline-none focus:border-blue-700 focus:ring focus:ring-blue-200"
            @click.prevent="register"
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
import { registerUser } from "@/api/user.js";
export default {
  setup() {
    // Reactive state properties
    const user_name = ref("");
    const password = ref("");
    const phone = ref("");
    const gender = ref("male"); // Initialize with an empty string or fetch from the store

    // Store and Router instances
    const store = userStore();
    const router = useRouter();

    // Login method
    const register = () => {
      const userInfo = {
        phone: phone.value,
        user_name: user_name.value,
        gender: gender.value,
        password: password.value,
      };
      registerUser(userInfo).then((res) => {
        console.log(res);
        if (res.success) {
          ElMessage({
            showClose: true,
            message: "注册成功",
            type: "success",
          });
          store.setUserInfo({
            token: res.data.user_id,
            right: 0,
          });
          router.push("/personalCenter");
        } else {
          ElMessage({
            showClose: true,
            message: res.message,
            type: "error",
          });
        }
      });
      // Redirect after setting user info
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
      user_name,
      password,
      gender,
      phone,
      register,
      open,
    };
  },
};
</script>
