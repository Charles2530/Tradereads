<template>
  <div class="product-item bg-white border rounded-lg p-4 flex flex-col">
    <div class="mb-2">
      <span class="text-lg font-bold">商品名称: {{ product.title }}</span>
    </div>
    <div class="mb-2">
      <span class="text-gray-600">价格: {{ product.price }}</span>
    </div>
    <div class="mb-2">
      <span>发往: {{ product.shippingAddress }}</span>
    </div>
    <div class="mb-2">
      <span
        :class="{
          'text-red-500': product.stock === 0,
          'text-green-500': product.stock > 0,
        }"
      >
        销售状态: {{ product.stock > 0 ? "有货" : "售完" }}
      </span>
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
import { ref, reactive, computed } from "vue";
export default {
  name: "ProductItem",
  props: {
    product: {
      type: Object,
      required: true,
    },
  },
  data: () => ({
    isEditing: ref(false),
  }),
  methods: {
    goToProductDetails(productId) {
      // Replace with your router logic or window location change
      //   this.$router.push(`/product/${productId}`);
    },
  },
};
</script>
