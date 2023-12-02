<template>
  <div class="container mx-auto p-4">
    <div class="mb-4">
      <h1 class="text-3xl font-semibold mb-2">二手书交易公告栏</h1>
      <p class="text-gray-600">浏览最新的二手书信息。</p>
    </div>

    <el-card class="mb-4" v-for="book in books" :key="book.id">
      <div class="flex justify-between items-center">
        <h2 class="text-xl font-semibold">{{ book.title }}</h2>
        <span class="text-gray-500">{{ book.date }}</span>
      </div>
      <p class="text-gray-700 mt-2">{{ book.description }}</p>
      <div class="mt-4 flex justify-end">
        <el-button type="primary" @click="viewDetails(book.id)"
          >查看详情</el-button
        >
      </div>
    </el-card>
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
/* Add Tailwind CSS classes as needed */
</style>
