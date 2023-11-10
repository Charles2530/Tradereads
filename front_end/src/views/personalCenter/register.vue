<template>
  <div class="register">
    <div
      class="register__container p-8 bg-white rounded shadow-lg max-w-md w-full"
    >
      <h1 class="register__title text-2xl font-bold mb-6 bg-black">register</h1>
      <form class="register__form">
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
import { userStore } from "../../store/user.js";
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
