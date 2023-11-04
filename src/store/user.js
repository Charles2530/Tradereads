// pinia 用户使用方法
import { defineStore } from "pinia";
export const userStore = defineStore({
  id: "user",
  // 数据
  state: () => {
    return {
      token: localStorage.getItem("token") || "",
      userInfo: JSON.parse(localStorage.getItem("userInfo")) || {},
    };
  },
  // 方法
  actions: {
    setUserInfo(data) {
      this.token = data.token;
      this.userInfo = data.userInfo;
      localStorage.setItem("token", this.token);
      localStorage.setItem("userInfo", JSON.stringify(this.userInfo));
    },
  },
});
