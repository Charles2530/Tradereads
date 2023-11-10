<template>
  <div class="login">
    <div
      class="login__container p-8 bg-white rounded shadow-lg max-w-md w-full"
    >
      <h1 class="login__title text-2xl font-bold mb-6 bg-black">Login</h1>
      <form class="login__form">
        <div class="login__text mb-4">
          <el-input
            class="w-full p-2 border rounded border-gray-300 focus:outline-none focus:border-blue-500"
            v-model="loginInfo.username"
            placeholder="Username"
          />
        </div>
        <div class="login__password mb-4">
          <el-input
            v-model="loginInfo.password"
            class="w-full p-2 border rounded border-gray-300 focus:outline-none focus:border-blue-500"
            type="password"
            placeholder="Password"
            show-password
          />
        </div>
        <div class="login__button">
          <button
            type="submit"
            class="w-full bg-blue-500 text-white p-2 rounded hover:bg-blue-600 focus:outline-none focus:border-blue-700 focus:ring focus:ring-blue-200"
            @click.prevent="Login"
          >
            Login
          </button>
        </div>
        <div class="registerUrl">
          <router-link to="/register">没有账号?点击注册!</router-link>
        </div>
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
