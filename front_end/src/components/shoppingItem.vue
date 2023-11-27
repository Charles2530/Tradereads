<template>
  <div class="item" :style="imgg">
    <div class="seller">卖家:{{ seller_name }}</div>
    <div class="price">价格:￥{{ product_price }}</div>
    <div class="name">书名:{{ product_name }}</div>
    <div class="num">加入购物车数量:{{ product_number }}</div>
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
  background: aliceblue no-repeat center 0px;
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

import shoppingItem from '../components/shoppingItem.vue';
export default {

  name: 'shoppingItem',
  data() {
    return {
      test: "2.jpg",
      project_title: "DataBase Project",
    };
  },
  computed: {
    imgg: function () {
      return "background-image: url(../../public/" + this.product_image + ");"
    }
  },
  props: {
    seller_name: {
      type: String,
      required: true,
    },
    product_name: {
      type: String,
      required: true,
    },
    product_number: {
      type: Number,
      required: true,
    },
    product_price: {
      type: Number,
      required: true,
    },
    product_image: {
      type: Number,
      required: true,
    },
  },
  mounted() {

  }
};


</script>