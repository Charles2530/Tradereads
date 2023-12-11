<template>
  <el-card class="mb-4" v-for="notice in notices" :key="notice.id">
    <div class="flex justify-between items-center">
      <h2 class="text-xl font-semibold">{{ notice.notice_title }}</h2>
      <span class="text-gray-500">{{ notice.notice_create_time }}</span>
    </div>
    <p class="text-gray-700 mt-2">{{ notice.notice_content }}</p>
  </el-card>
</template>

<script>
export default {
  name: "PublicNoticeList",
  props: {
    notices: {
      type: Array,
      required: true,
    },
  },
};
</script>

<style scoped></style>
