// pinia 用户使用方法
import { defineStore } from "pinia";
export const userStore = defineStore({
  id: "user",
  // 数据
  state: () => {
    return {
      token: localStorage.getItem("token") || "",
      right: localStorage.getItem("right") || 0,
    };
  },
  // 方法
  actions: {
    setUserInfo(data) {
      this.token = data.token;
      localStorage.setItem("token", this.token);
      this.right = data.right;
      localStorage.setItem("right", this.right);
    },
    clearUserInfo() {
      this.token = "";
      localStorage.removeItem("token");
      this.right = 0;
      localStorage.removeItem("right");
    },
  },
  // mutations
  mutations: {},
  // getters
  getters: {
    getToken() {
      return this.token;
    },
    getRight() {
      return this.right;
    },
    isLogin() {
      return this.token !== "";
    },
  },
});
