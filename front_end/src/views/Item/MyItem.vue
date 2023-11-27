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
        <p>我的商品</p>
        <div class="return"></div>
      </div>
      <div class="button">
        <my-Item></my-Item>
        <div v-for="{ p, index } in shoopingUser" :key="index">
          <MyItem :shoppinglist="p.data.products"></MyItem>
        </div>
        <!-- {{ shoopingUser.data.total_price }} -->
        
        <button class="generate" @click="generate()"></button>
      </div>
    </div>
  </div>
</template>

<style>
@import url("../../../css/base.css");
@import url("../../../css/MyItem.css");
</style>

<script>
export default {
  data() {
    return {
      project_title: "DataBase Project",
    };
  },
};
</script>
