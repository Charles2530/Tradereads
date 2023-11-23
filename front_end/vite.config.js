import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import AutoImport from "unplugin-auto-import/vite";
import Components from "unplugin-vue-components/vite";
import { ElementPlusResolver } from "unplugin-vue-components/resolvers";
import { resolve } from "path";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    AutoImport({
      resolvers: [ElementPlusResolver()],
    }),
    Components({
      resolvers: [ElementPlusResolver()],
    }),
  ],
  resolve: {
    alias: {
      "@": resolve(__dirname, "src"),
      "@c": resolve(__dirname, "src/components"),
      "@css": resolve(__dirname, "css"),
    },
  },
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
      "/api": "http://localhost:5000",
    },
  },
  build: {
    sourcemap: false, // 不生成 source map 
    terserOptions: { 
      compress: { // 打包时清除 console 和 debug 相关代码
        drop_console: true,
        drop_debugger: true,
      },
    },
  }
});
