<template>
  <div class="home">
    <div>
      <p class="home_sub">
        北&nbsp;航&nbsp;二&nbsp;手&nbsp;书&nbsp;网&nbsp;站<br />
        一个平台 帮助每一位北航人售购闲置二手书<br />
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
