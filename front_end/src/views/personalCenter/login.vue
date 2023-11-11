<template>
  <div
    class="min-h-screen bg-login-background bg-cover bg-center bg-no-repeat flex justify-end items-center p-10"
  >
    <div class="w-full max-w-xs bg-white p-8 rounded shadow-lg">
      <h1
        class="login_container text-2xl font-bold mb-6 bg-blue-500 text-white p-3 rounded text-center"
      >
        用户登录
      </h1>
      <form class="login__form space-y-4">
        <div>
          <el-input
            class="w-full p-2 border rounded border-gray-300 focus:outline-none focus:border-blue-500"
            v-model="loginInfo.username"
            placeholder="Username"
          />
        </div>
        <div>
          <el-input
            v-model="loginInfo.password"
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
        <router-link to="/register" class="inline-block mt-4"
          >没有账号?点击注册!</router-link
        >
      </form>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";
import { userStore } from "../../store/user.js";
export default {
  data: () => ({
    loginInfo: {
      username: ref(""),
      password: ref(""),
      email: userStore().$state.userInfo.email,
    },
  }),
  methods: {
    Login() {
      const store = userStore();
      store.setUserInfo({
        token: "123456789",
        userInfo: this.loginInfo,
      });
      store.setUserInfo(this.loginInfo);
      this.$router.push("/personalCenter");
    },
  },
};
</script>
