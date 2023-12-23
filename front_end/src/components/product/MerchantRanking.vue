<template>
  <div class="ranking-container bg-white my-4 p-2">
    <p class="flex justify-center text-4xl text-gray-500 my-3">商家排行榜</p>
    <seller-info v-for="merchant in merchants" :key="merchant.id">
    </seller-info>
  </div>
</template>

<script>
import sellerInfo from "./sellerInfo.vue";

export default {
  components: { sellerInfo },
  name: "merchantRanking",
  props: {
    merchants: {
      type: Array,
      required: true,
    },
  },
  setup() {},
};
</script>

<style scoped>
/* 样式 */
</style>
