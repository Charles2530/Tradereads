<!-- 通过关注列表访问其他用户的商品列表 -->
<template>
  <div class="product-item bg-white border rounded-lg p-4 flex flex-col">
    <div class="mb-2">
      <span class="text-lg font-bold"
        >商品名称: {{ product.product_name }}</span
      >
    </div>
    <div class="mb-2">
      <span class="text-gray-600">商品图片: {{ product.product_image }}</span>
    </div>
    <div class="mb-2">
      <span class="text-gray-600">价格: {{ product.price }}</span>
    </div>
    <div class="mb-2">
      <span class="text-gray-600">商品库存: {{ product.product_store }}</span>
    </div>
    <div>
      <span class="text-gray-600">发货地址: {{ product.sell_address }}</span>
    </div>
    <div>
      <span :class="stockClass">{{ stockStatus }}</span>
    </div>
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
  setup() {
    const stockClass = computed(() => ({
      "text-red-500": editableProduct.product_store === 0,
      "text-green-500": editableProduct.product_store > 0,
    }));
    const stockStatus = computed(() =>
      editableProduct.product_store > 0 ? "有货" : "售完"
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
