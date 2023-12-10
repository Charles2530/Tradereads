<template>
  <div
    class="min-h-screen bg-login-background bg-cover bg-center bg-no-repeat flex justify-end items-center p-10"
  >
    <div class="w-full max-w-xs bg-white p-8 rounded shadow-lg">
      <h1
        class="login_container text-2xl font-bold mb-6 bg-blue-500 text-white p-3 rounded text-center"
      >
        用户登录<el-icon class="text-cyan-400"><User /></el-icon>
      </h1>

      <form class="login__form space-y-4">
        <div>
          <el-input
            class="w-full p-2 border rounded border-gray-300 focus:outline-none focus:border-blue-500"
            v-model="phone"
            placeholder="Phone"
            clearable
          />
        </div>
        <div>
          <el-input
            v-model="password"
            class="w-full p-2 border rounded border-gray-300 focus:outline-none focus:border-blue-500"
            type="password"
            placeholder="Password"
            show-password
          />
        </div>
        <button
          type="submit"
          class="w-full bg-blue-500 text-white p-2 rounded hover:bg-blue-600 focus:outline-none"
          @click.prevent="Login"
        >
          Login
        </button>
        <router-link
          to="/register"
          class="inline-block mt-4 underline text-red-600"
          >没有账号?点击注册!</router-link
        >
      </form>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";
import { userStore } from "@/store/user.js"; // Make sure the path is correct
import { useRouter } from "vue-router";
import { loginUser } from "@/api/user.js";

export default {
  setup() {
    // Reactive state properties
    const phone = ref("");
    const password = ref("");

    // Store and Router instances
    const store = userStore();
    const router = useRouter();

    // Login method
    const Login = () => {
      const userInfo = {
        phone: phone.value,
        password: password.value,
      };
      loginUser(userInfo).then((res) => {
        console.log(res);
        if (res.success) {
          ElMessage({
            showClose: true,
            message: res.message,
            type: "success",
          });
          store.setUserInfo({
            token: res.data.user_id,
            right: res.data.right,
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
    };

    // Open notification
    const open = () => {
      ElMessage({
        showClose: true,
        message: "登录成功",
        type: "success",
      });
    };

    // Return the reactive state and methods to the template
    return {
      phone,
      password,
      Login,
      open,
    };
  },
};
</script>
