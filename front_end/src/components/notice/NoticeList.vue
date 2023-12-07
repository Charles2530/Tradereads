<template>
  <el-card class="mb-4" v-for="book in books" :key="book.id">
    <div class="flex justify-between items-center">
      <h2 class="text-xl font-semibold">{{ book.title }}</h2>
      <span class="text-gray-500">{{ book.date }}</span>
    </div>
    <p class="text-gray-700 mt-2">{{ book.description }}</p>
    <div class="mt-4 flex justify-end">
      <el-button
        type="primary"
        class="text-white font-semibold hover:underline"
        @click="viewDetails(book.id)"
        plain
      >
        <el-icon class="ml-1 mr-4"><Finished /></el-icon>
        查看详情</el-button
      >
    </div>
  </el-card>
</template>

<script>
export default {
  props: {
    books: {
      type: Array,
      required: true,
    },
  },
  setup() {
    const viewDetails = (bookId) => {
      console.log("View details for book with ID:", bookId);
    };
    return {
      viewDetails,
    };
  },
};
</script>

<style scoped>
.notice-detail:hover {
  color: #fff;
  text-decoration: underline;
}
</style>
