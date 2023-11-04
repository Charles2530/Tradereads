import axios from "axios";

let baseURL = "/api";

const service = axios.create({
  baseURL,
  timeout: 5000,
});

// 请求拦截器
service.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem("token");
    if (token) {
      config.headers["x-access-token"] = token;
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
    const res = response.data;
    if (response.status !== 200) {
      return Promise.reject(new Error(res.success || "error"));
    } else {
      if (res.code === 200) {
        return res.result;
      } else {
        alert(res.success);
      }
    }
  },
  (error) => {
    return Promise.reject(error);
  }
);

export default service;
