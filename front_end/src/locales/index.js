// import sysConfig from "@/config";
import { createI18n } from "vue-i18n";
import elZhCn from "element-plus/es/locale/lang/zh-cn";
import elEn from "element-plus/es/locale/lang/en";
import zh_CN from "./lang/zh-cn";
import en from "./lang/en";

const messages = {
  zh_CN: {
    el: elZhCn.el,
    ...zh_CN,
  },
  en: {
    el: elEn.el,
    ...en,
  },
};

const i18n = createI18n({
  locale: localStorage.getItem("LANG"),
  fallbackLocale: "zh_CN",
  globalInjection: true,
  messages,
});

export default i18n;
