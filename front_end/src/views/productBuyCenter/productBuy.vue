<template>
  <div class="all">
    <div class="sidebar" id="root">
      <div class="icon one"></div>
      <div class="icon two"></div>
      <div class="icon three">
        <router-link to="/shopping"></router-link>
      </div>
      <div class="icon four"></div>
      <div class="icon five">
        <router-link to="/ProductBuy"></router-link>
      </div>
    </div>
    <div class="main">
      <div class="header">
        <p>商品中心</p>
        <div class="return"></div>
      </div>
      <div class="button">
        <buyProductItem></buyProductItem>
      </div>
    </div>
  </div>
</template>

<style>
@import url("../../../css/base.css");
@import url("../../../css/productBuy.css");
@import url("../../../css/shopping.css");
</style>

<script>
import buyProductItem from "../../components/buyProductItem.vue";
export default {
  data() {
    return {
      project_title: "DataBase Project",
    };
  },
};
</script>
