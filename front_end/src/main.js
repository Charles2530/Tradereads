import { createApp } from "vue";
import "./style.css";
import App from "./App.vue";
import store from "./store";
import router from "./router";
import * as ElementPlusIconsVue from "@element-plus/icons-vue";
import ElementPlus from "element-plus";
import i18n from "@/locales";
// import config from "@/config/index.js";
const app = createApp(App);
app.config.globalProperties.$i18n = i18n.global;
// app.config.globalProperties.$CONFIG = config;

for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
  app.component(key, component);
}

app.use(ElementPlus);
app.use(store);
app.use(router);
app.use(i18n);
app.mount("#app");
