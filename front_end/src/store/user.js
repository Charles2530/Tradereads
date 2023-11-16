// pinia 用户使用方法
import { defineStore } from "pinia";
export const userStore = defineStore({
  id: "user",
  // 数据
  state: () => {
    return {
      token: localStorage.getItem("token") || "",
      //   userInfo: JSON.parse(localStorage.getItem("userInfo")) || {},
      userInfo: localStorage.getItem("userInfo") || {},
    };
  },
  // 方法
  actions: {
    setUserInfo(data) {
      this.token = data.token;
      this.userInfo = data.userInfo;
      localStorage.setItem("token", this.token);
      //   localStorage.setItem("userInfo", JSON.stringify(this.userInfo));
      localStorage.setItem("userInfo", this.userInfo);
    },
    clearUserInfo() {
      this.token = "";
      this.userInfo = {};
      localStorage.removeItem("token");
      localStorage.removeItem("userInfo");
    },
  },
  // mutations
  mutations: {
    setName(name) {
      this.loginInfo.username = name;
      localStorage.setItem("userInfo", this.userInfo);
    },
    setEmail(email) {
      this.loginInfo.email = email;
      localStorage.setItem("userInfo", this.userInfo);
    },
    setAvatar(avatar) {
      this.loginInfo.avatar = avatar;
      localStorage.setItem("userInfo", tshis.userInfo);
    },
  },
  // getters
  getters: {
    getToken() {
      return this.token;
    },
    getUserInfo() {
      return this.userInfo;
    },
  },
});
