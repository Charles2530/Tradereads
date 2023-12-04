<!-- 通过关注列表访问其他用户的商品列表 -->
<template>
  <div class="product-item bg-white border rounded-lg p-4 flex flex-col">
    <el-row class="mb-2">
      <el-col :span="24">
        <span class="text-lg font-bold"
          >商品名称: {{ product.product_name }}</span
        >
      </el-col>
    </el-row>

    <el-row class="mb-2">
      <el-col :span="12" class="mb-2">
        <el-row class="mb-5">
          <span class="text-gray-600">价格: {{ product.price }}</span>
        </el-row>
        <el-row class="mb-5">
          <span class="text-gray-600"
            >商品库存: {{ product.product_store }}</span
          >
        </el-row>
        <el-row class="mb-5">
          <span class="text-gray-600"
            >发货地址: {{ product.sell_address }}</span
          >
        </el-row>
        <el-row class="mb-5 text-xl">
          <span :class="stockClass">{{ stockStatus }}</span>
          <span :class="examineClass">{{ examineStatus }}</span>
        </el-row>
      </el-col>
      <el-col :span="12" class="text-center">
        <div>
          <img
            :src="product.product_image"
            alt="Product Image"
            class="w-48 h-48 mb-2"
          />
        </div>
      </el-col>
    </el-row>
    <button
      class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
      @click="goToProductDetails(product.id)"
    >
      详细信息
    </button>
  </div>
</template>

<script>
import { computed } from "vue";
export default {
  name: "ProductItemRead",
  props: {
    product: {
      type: Object,
      required: true,
    },
  },
  setup(props) {
    const stockClass = computed(() => ({
      "text-red-500": props.product.product_store === 0,
      "text-green-500": props.product.product_store > 0,
    }));
    const stockStatus = computed(() =>
      props.product.product_store > 0 ? "有货" : "售完"
    );

    const goToProductDetails = (productId) => {
      // Replace with your router logic or window location change
      // this.$router.push(`/product/${productId}`);
    };

    // Expose the properties and methods to the template
    return {
      stockClass,
      stockStatus,
      goToProductDetails,
    };
  },
};
</script>

<style scoped>
.product-item {
  width: calc(50% - 8px); /* 50% width with some spacing */
  margin-bottom: 16px; /* Add some bottom margin for spacing */
}

.button-container {
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>
