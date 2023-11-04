import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  //线上接口
  //   server:{
  //     port : 8002,
  //     open : true,
  //     proxy :{
  //         '/api':{
  //             target: 'http://localhost:3000',
  //             changeOrigin: true,
  //             rewrite: (path) => path.replace(/^\/api/, '')
  //         }
  //     },
  //     cors:true
  //   },
  //本地接口
  server: {
    proxy: {
      "/api": "http://localhost:3000",
    },
  },
});
