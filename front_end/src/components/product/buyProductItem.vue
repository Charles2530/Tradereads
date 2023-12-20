<template>
  <div>
    <el-row gutter="2">
      <el-col :span="8">
        <el-row>
          <img
            :src="product.product_image"
            alt="Product Image"
            class="w-48 h-48"
          />
        </el-row>
        <el-row>
          <el-col :span="18">
            <span class="text-lg font-bold">{{ product.product_name }}</span>
          </el-col>
          <el-col :span="6">
            <span class="text-gray-600">价格: {{ product.price }}</span>
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
