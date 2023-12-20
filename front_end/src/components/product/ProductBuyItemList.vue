<template>
  <div>
    <div v-for="(product, index) in products" :key="product.product_id">
      <template v-if="index % 5 === 0">
        <buy-product-item :product="product" />
        <buy-product-item
          :product="products[index + 1]"
          v-if="index + 1 <= products.length - 1"
        />
        <buy-product-item
          :product="products[index + 2]"
          v-if="index + 2 <= products.length - 1"
        />
        <buy-product-item
          :product="products[index + 3]"
          v-if="index + 3 <= products.length - 1"
        />
        <buy-product-item
          :product="products[index + 4]"
          v-if="index + 4 <= products.length - 1"
        />
      </template>
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
      type: Array,
      required: true,
    },
  },
  setup(props) {},
};
</script>

<style scoped>
.row-divider {
  height: 1px;
  background-color: #e2e8f0;
  margin-top: 16px;
}
</style>
