<template>
  <div
    class="bg-admin-background bg-cover bg-center bg-no-repeat p-4 min-h-screen"
  >
    <div style="position: relative; z-index: 1">
      <personal-center-side-bar />
    </div>
    <div class="m-100 bg-white" style="position: relative; z-index: 0">
      <h1 class="text-4xl font-bold mb-8 flex justify-center">商品审核中心</h1>
      <el-divider></el-divider>
      <el-table :data="filteredProducts" style="width: 100%">
        <el-table-column label="商品名称" prop="name"></el-table-column>
        <el-table-column label="价格" prop="price"></el-table-column>
        <el-table-column label="状态" prop="isApproved">
          <template #default="scope">
            <span
              :class="{
                'text-green-500': scope.row.isApproved,
                'text-red-500': !scope.row.isApproved,
              }"
            >
              {{ scope.row.isApproved ? "已审核" : "待审核" }}
            </span>
          </template>
        </el-table-column>
        <el-table-column label="操作">
          <template #default="scope">
            <el-button
              v-if="!scope.row.isApproved"
              @click="approveProduct(scope.row)"
              >审核通过</el-button
            >
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from "vue";

const products = ref([
  { id: 1, name: "Product 1", price: 50, isApproved: true },
  { id: 2, name: "Product 2", price: 30, isApproved: false },
  { id: 3, name: "Product 3", price: 40, isApproved: true },
  // Add more products as needed
]);

const filteredProducts = computed(() => {
  // Only show approved products
  return products.value.filter((product) => product.isApproved);
});

const approveProduct = (product) => {
  // Simulate an approval process (update the product status)
  product.isApproved = true;
};
</script>

<style scoped>
/* Add your Tailwind CSS styles here */
</style>
