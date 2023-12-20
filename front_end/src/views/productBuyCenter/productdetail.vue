<template>
  <div>
    <div class="bg-blue-200/70">
      <navigation-bar />
      <div class="bg-detail-background bg-cover bg-center p-4 min-h-screen">
        <div style="position: relative; z-index: 1">
          <personal-center-side-bar />
        </div>
        <div style="position: relative; z-index: 0">
          <div><product-detail-message :product_id="product_id" /></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import personalCenterSideBar from "@c/user/personalCenterSideBar.vue";
import NavigationBar from "@c/home/NavigationBar.vue";
import productDetailMessage from "@c/product/ProductDetailMessage.vue";
const context = defineProps(["product_id"]);
const product_id = parseInt(context.product_id);
</script>
