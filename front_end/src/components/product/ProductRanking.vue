<template>
  <div class="product-ranking my-4 p-2 bg-white">
    <p class="flex justify-center text-4xl text-gray-500 my-3">今日商品推荐</p>
    <buy-product-item
      class="ml-2"
      v-for="product in products"
      :key="product.product_id"
      :product="product"
    />
  </div>
</template>

<script>
export default {
  name: "productRanking",
  props: {
    products: {
      type: Array,
      required: true,
    },
  },
};
</script>
