<template>
  <el-card class="mb-4" v-for="book in books" :key="book.id">
    <div class="flex justify-between items-center">
      <h2 class="text-xl font-semibold">{{ book.notice_title }}</h2>
      <span class="text-gray-500">{{ book.notice_date }}</span>
    </div>
    <p class="text-gray-700 mt-2">{{ book.notice_content }}</p>
    <div class="mt-4 flex justify-end">
      <el-button
        type="primary"
        class="text-white font-semibold hover:underline"
        @click="viewDetails(book.notice_user_id)"
        plain
      >
        <el-icon class="ml-1 mr-4"><Finished /></el-icon>
        点击进入个人中心</el-button
      >
    </div>
  </el-card>
</template>

<script>
import { useRouter } from "vue-router";
export default {
  name: "FollowNoticeList",
  props: {
    books: {
      type: Array,
      required: true,
    },
  },
  setup() {
    const router = useRouter();
    const viewDetails = (user_id) => {
      router.push({
        name: "FollowDetail",
        params: {
          user_id,
        },
      });
    };
    return {
      viewDetails,
    };
  },
};
</script>

<style scoped></style>
