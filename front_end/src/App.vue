<template>
  <el-config-provider :locale="locale">
    <router-view />
  </el-config-provider>
</template>
<script setup>
import { ElConfigProvider } from "element-plus";
import { getCurrentInstance, onMounted } from "vue";
import zh_cn from "element-plus/es/locale/lang/zh-cn";
import en from "element-plus/es/locale/lang/en";
const langComponent = {
  zh_CN: zh_cn,
  en: en,
};
const { proxy } = getCurrentInstance();
const lang = localStorage.getItem("lang") || "zh_CN";
const locale = langComponent[lang];
onMounted(() => {
  proxy.$i18n.locale = lang;
});
</script>
