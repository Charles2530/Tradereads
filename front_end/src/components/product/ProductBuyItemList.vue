<template>
  <div>
    <div v-for="product in products" :key="product.product_id">
      <buy-product-item :product="product" />
    </div>
  </div>
</template>
<script>
import buyProductItem from "@c/product/buyProductItem.vue";
export default {
  components: { buyProductItem },
  name: "ProductBuyItemList",
  props: {
    products: {
      type: Object,
      required: true,
    },
  },
  setup(props) {},
};
</script>
