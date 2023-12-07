<template>
  <div class="bg-home-background home">
    <div>
      <h1 class="home_sub_title">Tradereads</h1>
      <p class="home_sub">
        一个平台 帮助每一位北航人售购闲置二手书!<br />
        <router-link to="/login" class="home_sub"></router-link>
      </p>
    </div>

    <div>
      <span class="arrow-icon"> </span>
    </div>
    <br />
  </div>
</template>

<style>
@import url("../../../css/base.css");
@import url("../../../css/home.css");
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
