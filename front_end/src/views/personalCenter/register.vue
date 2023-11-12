<template>
  <div
    class="min-h-screen bg-login-background bg-cover bg-center bg-no-repeat flex justify-end items-center p-10"
  >
    <div class="w-full max-w-xs bg-white p-8 rounded shadow-lg">
      <h1
        class="register__title text-2xl font-bold mb-6 bg-blue-500 text-white p-3 rounded text-center"
      >
        注册用户
      </h1>
      <form class="register__form space-y-4">
        <div class="register__text mb-4">
          <el-input
            class="w-full p-2 border rounded border-gray-300 focus:outline-none focus:border-blue-500"
            v-model="registerInfo.username"
            placeholder="Username"
          />
        </div>
        <div class="register__password mb-4">
          <el-input
            v-model="registerInfo.password"
            class="w-full p-2 border rounded border-gray-300 focus:outline-none focus:border-blue-500"
            type="password"
            placeholder="Password"
            show-password
          />
        </div>
        <div class="register__email mb-4">
          <el-input
            v-model="registerInfo.email"
            class="w-full p-2 border rounded border-gray-300 focus:outline-none focus:border-blue-500"
            type="email"
            placeholder="Email"
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
import { userStore } from "@/store/user.js";
export default {
  data: () => ({
    registerInfo: {
      username: ref(""),
      password: ref(""),
      email: ref(""),
    },
  }),
  methods: {
    register() {
      const store = userStore();
      store.setUserInfo({
        token: "123456789",
        userInfo: this.registerInfo,
      });
      store.setUserInfo(this.registerInfo);
      this.$router.push("/personalCenter");
    },
  },
};
</script>
