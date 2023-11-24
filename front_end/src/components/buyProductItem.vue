<template>
  <div class="item">
    <div class="seller">seller:xuan</div>
    <div class="price">price:￥100</div>
    <div class="name">name:离散</div>
    <div class="num">num:20</div>
    <div class="add" @click="count++"></div>
    <div class="count">{{ count }}</div>
    <div class="sub" @click="count > 0 ? count-- : count"></div>
    <div class="bought" @click="buything"></div>
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
  left: 20px;
}

.price {
  position: absolute;
  font-size: 25px;
  bottom: 60px;
  left: 20px;
}

.name {
  position: absolute;
  font-size: 25px;
  bottom: 100px;
  left: 20px;
}

.num {
  position: absolute;
  font-size: 25px;
  bottom: 140px;
  left: 20px;
}

.add {
  position: absolute;
  font-family: "icomoon";
  font-size: 20px;
  content: "\ea0a";
  bottom: 60px;
  right: 90px;
}

.add:hover {
  color: aqua;
  font-size: 20px;
}

.sub {
  position: absolute;
  font-family: "icomoon";
  font-size: 20px;
  content: "\ea0b";
  bottom: 60px;
  right: 10px;
}

.sub:hover {
  color: aqua;
  font-size: 20px;
}

.count {
  position: absolute;
  font-size: 20px;
  bottom: 60px;
  right: 50px;
}

.bought {
  position: absolute;
  position: absolute;
  font-family: "icomoon";
  font-size: 30px;
  content: "\ea11";
  bottom: 10px;
  right: 30px;
}

.bought:hover {
  color: aqua;
  font-size: 40px;
}
</style>

<script>
import buyProductItem from "../components/buyProductItem.vue";
export default {
  setup() {
    // Open notification
    const open = () => {
      ElMessage({
        showClose: true,
        message: this.message,
        type: "success",
      });
    };
  },
  name: "buyProductItem",
  data() {
    return {
      count: 0,
      message: "",
      project_title: "DataBase Project",
    };
  },
  methods: {
    buything() {
      let t = { count: this.count, message: this.message };

      addProductToCart(t);
      this.message = t.message;
      open();
    },
  },
  props: ["shoppinglist"],
};
</script>
