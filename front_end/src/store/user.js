// pinia 用户使用方法
import { defineStore } from "pinia";
export const userStore = defineStore({
  id: "user",
  // 数据
  state: () => {
    return {
      token: localStorage.getItem("token") || "",
    };
  },
  // 方法
  actions: {
    setUserInfo(data) {
      this.token = data.token;
      localStorage.setItem("token", this.token);
    },
    clearUserInfo() {
      this.token = "";
      localStorage.removeItem("token");
    },
  },
  // mutations
  mutations: {},
  // getters
  getters: {
    getToken() {
      return this.token;
    },
    isLogin() {
      return this.token !== "";
    },
  },
});
