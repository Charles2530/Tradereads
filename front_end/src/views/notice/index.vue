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
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      books: [
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
        // Add more books as needed
      ],
    };
  },
  methods: {
    viewDetails(bookId) {
      // Implement your logic to view book details
      console.log("View details for book with ID:", bookId);
    },
  },
};
</script>

<style scoped>
.notice-detail:hover {
  color: #fff;
  text-decoration: underline;
}
</style>
