<template>
  <div>
    <div
      class="bg-ranking-background bg-cover bg-center bg-no-repeat p-4 min-h-screen pl-12"
    >
      <div style="position: relative; z-index: 1">
        <personal-center-side-bar />
      </div>
      <div class="container mx-auto p-4" style="position: relative; z-index: 0">
        <div class="mb-4 ml-20">
          <h1 class="text-3xl font-semibold mb-2 text-white">排行榜</h1>
          <p class="text-white notice-detail">快来选购你想要的二手书吧!</p>
          <product-ranking :products="RecommendProducts" />
          <merchant-ranking :merchants="UserRankList" />
        </div>
      </div>
    </div>
  </div>
</template>
<script setup>
import { showAllProducts } from "@/api/product.js";
import { showUserRankTable } from "@/api/statistic.js";
import { ref, onMounted } from "vue";
const RecommendProducts = ref([]);
const UserRankList = ref([]);
onMounted(() => {
  showAllProducts().then((res) => {
    if (res.success) {
      const shuffledProducts = res.data.products.sort(
        () => 0.5 - Math.random()
      );
      const maxProducts = Math.min(shuffledProducts.length, 5);
      RecommendProducts.value = shuffledProducts.slice(0, maxProducts);
    }
  });
  showUserRankTable().then((res) => {
    if (res.success) {
      console.log(res.data.statistics);
      UserRankList.value = res.data.statistics;
    }
  });
});
</script>
<style scope>
.notice-detail:hover {
  text-decoration: underline;
}
</style>
