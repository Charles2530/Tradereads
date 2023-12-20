<template>
  <div>
    <div v-if="notices.length === 0">
      <h1 class="text-2xl text-center text-white font-bold">当前没有公告</h1>
    </div>
    <div>
      <el-card class="mb-4" v-for="notice in notices" :key="notice.id">
        <div>
          <div v-if="!notice.notice_readed">
            <el-tag type="warning" round>
              <el-icon><ReadingLamp /></el-icon>
              未读</el-tag
            >
          </div>
        </div>
        <div class="flex justify-between items-center">
          <h2 class="text-xl font-semibold">{{ notice.notice_title }}</h2>
          <span class="text-gray-500">{{ notice.notice_create_time }}</span>
        </div>
        <p class="text-gray-700 mt-2">{{ notice.notice_content }}</p>
      </el-card>
    </div>
  </div>
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
