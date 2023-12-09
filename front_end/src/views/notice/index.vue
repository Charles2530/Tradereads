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
        <p class="text-gray-600 notice-detail">浏览最新的二手书信息。</p>
      </div>
      <div>
        <notice-list :books="books" />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";
import NoticeList from "@c/notice/NoticeList.vue";
const books = ref([
  {
    id: 1,
    title: "Book Title 1",
    description: "Book Description 1",
    date: "2023-01-01",
  },
  {
    id: 2,
    title: "Book Title 2",
    description: "Book Description 2",
    date: "2023-02-01",
  },
]);
</script>

<style>
.notice-detail:hover {
  color: #fff;
  text-decoration: underline;
}
</style>
