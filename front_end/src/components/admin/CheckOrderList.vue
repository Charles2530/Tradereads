<template>
  <div class="m-100 bg-white" style="position: relative; z-index: 0">
    <h1 class="text-4xl font-bold mb-8 flex justify-center">商品审核中心</h1>
    <el-divider></el-divider>
    <div v-if="products.length === 0">
      <h1 class="text-2xl text-center">没有待审核的商品</h1>
    </div>
    <div v-else>
      <el-table :data="products" style="width: 100%">
        <el-table-column label="商品名称" prop="product_name"></el-table-column>
        <el-table-column label="价格" prop="price"></el-table-column>
        <el-table-column
          label="商品出版社"
          prop="product_press"
        ></el-table-column>
        <el-table-column
          label="商家用户名"
          prop="seller_name"
        ></el-table-column>
        <el-table-column
          label="商品发货地址"
          prop="sell_address"
        ></el-table-column>
        <el-table-column label="状态" prop="check_state">
          <template #default="scope">
            <span
              :class="{
                'text-green-500': scope.row.check_state,
                'text-red-500': !scope.row.check_state,
              }"
            >
              {{ scope.row.check_state ? "已审核" : "待审核" }}
            </span>
          </template>
        </el-table-column>
        <el-table-column label="操作">
          <template #default="scope">
            <el-button
              v-if="!scope.row.check_state"
              @click="approveProduct(scope.row)"
              >审核通过</el-button
            >
            <el-button
              v-if="!scope.row.check_state"
              @click="disapproveProduct(scope.row)"
              >审核不通过</el-button
            >
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>
<script>
import { ExamineProduct } from "@/api/examine.js";
export default {
  name: "CheckOrderList",
  props: {
    products: {
      type: Array,
      required: true,
    },
  },
  setup() {
    const approveProduct = (product) => {
      // Simulate an approval process (update the product status)
      product.check_state = true;
      const check_result = 1;
      ExamineProduct(product.product_id, { check_result }).then((res) => {
        if (res.success) {
          console.log(res.data);
        } else {
          ElMessage({
            message: res.message,
            type: "error",
          });
        }
      });
    };

    const disapproveProduct = (product) => {
      // Simulate a disapproval process (update the product status)
      product.check_state = true;
      const check_result = 0;
      ExamineProduct(product.product_id, { check_result }).then((res) => {
        if (res.success) {
          console.log(res.data);
        } else {
          ElMessage({
            message: res.message,
            type: "error",
          });
        }
      });
    };
    return {
      approveProduct,
      disapproveProduct,
    };
  },
};
</script>

<style scoped>
/* Add your Tailwind CSS styles here */
</style>
