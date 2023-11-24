<template>
  <div class="item">
    <div class="seller">seller:xuan</div>
    <div class="price">price:￥100</div>
    <div class="name">name:离散</div>
    <div class="num">num:20</div>
  </div>
</template>

<style>
@import url("../../css/base.css");

.item {
  position: relative;
  float: left;
  width: 23%;
  height: 500px;
  margin: 14px;
  border-radius: 40px;
  background: aliceblue url(../public/b6f14a73538b2836af10722a34e23627.jpg)
    no-repeat center 0px;
  background-size: 300px;
}

.seller {
  position: absolute;
  font-size: 25px;
  bottom: 20px;
  right: 20px;
}

.price {
  position: absolute;
  font-size: 25px;
  bottom: 60px;
  right: 20px;
}

.name {
  position: absolute;
  font-size: 25px;
  bottom: 100px;
  right: 20px;
}

.num {
  position: absolute;
  font-size: 25px;
  bottom: 140px;
  right: 20px;
}
</style>

<script>
import shoppingItem from "../components/shoppingItem.vue";
export default {
  name: "shoppingItem",
  data() {
    return {
      project_title: "DataBase Project",
    };
  },
  props: ["shoppinglist"],
};
</script>
