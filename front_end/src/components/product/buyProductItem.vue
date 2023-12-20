<template>
  <div class="p-1 border rounded-lg shadow-lg product-item">
    <el-row>
      <el-col :span="24">
        <el-row>
          <img :src="product.product_image" alt="Product Image" />
        </el-row>
        <el-row class="mx-2">
          <el-col :span="18">
            <span class="text-md font-bold">{{ product.product_name }}</span>
          </el-col>
          <el-col :span="6">
            <span class="text-md text-gray-600">￥{{ product.price }}</span>
          </el-col>
        </el-row>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  name: "buyProductItem",
  props: {
    product: {
      type: Object,
      required: true,
    },
  },
  setup(props) {},
};
</script>

<style scoped>
.product-item {
  width: 19%;
  margin-bottom: 16px;
  margin-right: 1%;
  display: inline-block;
}
</style>
