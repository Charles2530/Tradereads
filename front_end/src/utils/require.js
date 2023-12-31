import axios from "axios";
/* Mock 使用 */
let baseURL = import.meta.env.VITE_APP_BASE_API;
// let baseURL = "/api";

const service = axios.create({
  baseURL,
  timeout: 5000,
  //   headers: {
  //     "Content-Type": "application/json",
  //     Authorization: "Bearer " + localStorage.getItem("token"),
  //   },
});

// 请求拦截器
service.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem("token");
    if (token) {
      config.headers["x-access-token"] = token;
    } else {
      /*       ElMessage({
        showClose: true,
        type: "success",
        message: "使用应用前请先登录",
      }); */
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// 响应拦截器
service.interceptors.response.use(
  (response) => {
    if (response.status !== 200) {
      return Promise.reject(new Error(response.statusText || "error"));
    }
    return response.data;
  },
  (error) => {
    // 处理响应错误
    console.log(error);
    return Promise.reject(error);
  }
);

export default service;
