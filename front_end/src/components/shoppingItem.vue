<template>
  <div class="item">
    <div class="img" :style="imgg"></div>
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
  width: 30%;
  height: 500px;
  margin: 14px;
  border-radius: 40px;
  background-size: 300px;
  overflow-y: scroll;
  overflow-x: scroll;
}

.img {
  position: absolute;
  height: 400px;
  width: 100%;
  background: aliceblue url(../../public/b6f14a73538b2836af10722a34e23627.jpg) no-repeat center 0px;
  top: 0px;
  background-size: contain;

}

.seller {
  position: absolute;
  font-size: 25px;
  top: 520px;
  right: 20px;
  line-height: 30px;
}

.price {
  position: absolute;
  font-size: 25px;
  top: 560px;
  right: 20px;
  line-height: 30px;
}

.name {
  position: absolute;
  font-size: 25px;
  top: 600px;
  right: 20px;
  line-height: 30px;
}

.num {
  position: absolute;
  font-size: 25px;
  top: 640px;
  right: 20px;
  line-height: 30px;
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
      //return "background-image: url(../../public/" + "4.jpg" + ");"
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