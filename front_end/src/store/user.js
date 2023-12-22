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
    initialize() {
      const storedToken = localStorage.getItem("token");
      const storedRight = localStorage.getItem("right");
      if (storedToken) {
        this.token = storedToken;
      }
      if (storedRight) {
        this.right = storedRight;
      }
    },
    setUserInfo(data) {
      console.log("login:", data);
      this.token = data.token;
      console.log(this.token);
      localStorage.setItem("token", this.token);
      console.log(localStorage.getItem("token"));
      this.right = data.right;
      console.log(this.right);
      localStorage.setItem("right", this.right);
      console.log(localStorage.getItem("right"));
    },
    clearUserInfo() {
      console.log("logout");
      localStorage.clear();
    },
  },
  // mutations
  mutations: {},
  // getters
  getters: {
    getToken() {
      console.log(localStorage.getItem("token"));
      this.token = localStorage.getItem("token");
      return this.token;
    },
    // 0: 普通用户 1: 管理员
    getRight() {
      console.log(localStorage.getItem("right"));
      this.right = localStorage.getItem("right");
      return this.right;
    },
    isLogin() {
      return this.token != "";
    },
  },
});
