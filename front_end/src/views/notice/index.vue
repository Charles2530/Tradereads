<template>
  <div
    class="bg-notice-background bg-cover bg-center bg-no-repeat p-4 min-h-screen pl-12"
  >
    <div style="position: relative; z-index: 1">
      <personal-center-side-bar />
    </div>
    <div class="container mx-auto p-4" style="position: relative; z-index: 0">
      <div class="mb-4">
        <h1 class="text-3xl font-semibold mb-2 text-white">二手书交易公告栏</h1>
        <p class="text-gray-400 notice-detail">浏览最新的二手书信息。</p>
      </div>
      <div>
        <el-tabs v-model="activeName" class="demo-tabs">
          <el-tab-pane label="公共通知" name="first"
            ><public-notice-list :notices="notices"
          /></el-tab-pane>
          <el-tab-pane label="我的关注" name="Config">
            <follow-notice-list :books="books" />
          </el-tab-pane>
        </el-tabs>
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref, computed } from "vue";
import { showCurrentNotices } from "@/api/notice.js";
import PublicNoticeList from "@c/notice/PublicNoticeList.vue";
import FollowNoticeList from "@c/notice/FollowNoticeList.vue";
const activeName = ref("first");
const AllNotice = ref([]);
onMounted(() => {
  showCurrentNotices().then((res) => {
    if (res.success) {
      console.log(res.data.notice);
      AllNotice.value = res.data.notice;
    } else {
      ElMessage({
        showClose: true,
        type: "error",
        message: res.message,
      });
    }
  });
});
const notices = computed(() => {
  return AllNotice.value.filter((item) => {
    return item.notice_type === 0;
  });
});
const books = computed(() => {
  return AllNotice.value.filter((item) => {
    return item.notice_type === 1;
  });
});
</script>

<style>
.notice-detail:hover {
  color: #fff !important;
  text-decoration: underline;
}

.el-tabs__item {
  color: #fff !important;
}

.el-tabs__item.is-active {
  color: #409eff !important;
}
</style>
