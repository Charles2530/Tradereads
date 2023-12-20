<template>
  <div class="item1">
    <div class="img" :style="imgg" @click="deliverParams()"></div>

    <div div class="seller">
      <span class="bold">
        卖&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;家:
      </span>
      {{ seller_name }}
    </div>
    <div class="price">
      <span class="bold">
        价&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格:
      </span>
      ￥{{ price }}
    </div>
    <div class="name">
      <span class="bold">
        书&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名:
      </span>
      {{ product_name }}
    </div>
    <div class="num">
      <span class="bold"> 发货地址: </span>
      {{ sell_address }}
    </div>
    <div class="press">
      <span class="bold"> 出&nbsp;版&nbsp;&nbsp;社: </span>
      {{ product_press }}
    </div>
    <div class="type">
      <span class="bold">
        类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型:
      </span>
      {{ product_type }}
    </div>

    <div class="add" @click="count++"></div>
    <div class="count">{{ count }}</div>
    <div class="sub" @click="count > 0 ? count-- : count"></div>
    <div class="bought" @click="buything"></div>
    <!-- <div class="goto" @click="deliverParams()">
      
    </div> -->
  </div>
</template>

<style>
@import url("../css/base.css");

.item1 {
  position: relative;
  float: left;
  width: 31.5%;
  height: 500px;
  margin: 14px;
  border-radius: 40px;
  background-size: 300px;

  white-space: nowrap;
  text-overflow: ellipsis;
  overflow: hidden;

  border: 1px solid blue;
  border-radius: 30px;
  box-shadow: 10px 10px 3px rgba(141, 138, 138, 0.3);
}

.bold {
  font-weight: bold;
  white-space: nowrap;
  text-overflow: ellipsis;
  overflow: hidden;
}

.img {
  position: absolute;
  height: 300px;
  width: 42%;
  background: aliceblue url(../public/1.jpg) no-repeat center 0px;
  top: 15px;
  background-size: contain;
}

.seller {
  position: absolute;
  font-size: 20px;
  height: 40px;
  top: 20px;
  left: 43%;
  line-height: 30px;
}

.price {
  position: absolute;
  font-size: 20px;
  top: 80px;
  left: 43%;
  line-height: 30px;
  overflow: hidden;
}

.name {
  position: absolute;
  font-size: 20px;
  top: 140px;
  left: 43%;
  line-height: 30px;
  overflow: hidden;
}

.num {
  position: absolute;
  font-size: 20px;
  top: 200px;
  left: 43%;
  line-height: 30px;
  overflow: hidden;
}

.press {
  position: absolute;
  font-size: 20px;
  top: 260px;
  left: 43%;
  line-height: 30px;
  overflow: hidden;
}

.type {
  position: absolute;
  font-size: 20px;
  top: 320px;
  left: 43%;
  line-height: 30px;
}

.add {
  position: absolute;
  font-family: "icomoon";
  font-size: 20px;
  content: "\ea0a";
  top: 400px;
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
  top: 400px;
  right: 10px;
}

.sub:hover {
  color: aqua;
  font-size: 20px;
}

.count {
  position: absolute;
  font-size: 20px;
  top: 400px;
  right: 50px;
}

.bought {
  position: absolute;
  position: absolute;
  font-family: "icomoon";
  font-size: 30px;
  content: "\ea11";
  top: 440px;
  right: 40px;
}

.goto {
  position: absolute;
  position: absolute;
  font-family: "icomoon";
  font-size: 30px;
  content: "\ea34";
  top: 0px;
  right: 10px;
}

.goto:hover {
  font-size: 40px;
  color: aqua;
}

.bought:hover {
  color: aqua;
  font-size: 40px;
}
</style>

<script>
import buyProductItem from "../components/buyProductItem.vue";
import { addProductToCart } from "@/api/product.js";
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
      test: "2.jpg",
      count: 0,
      message: "",
      project_title: "DataBase Project",
    };
  },
  computed: {
    imgg: function () {
      //return "background-image: url(src/public/" + this.product_image + ");"
      return "background-image: url(src/public/" + "4.jpg" + ");";
    },
  },
  methods: {
    deliverParams() {
      let i = this.product_id;
      this.$router.push({
        name: "ProductDetail",
        params: {
          id: i,
        },
      });
    },
    openMessage(message) {
      ElMessage({
        showClose: true,
        message: "加入购物车成功！",
        type: "success",
      });
    },
    buything() {
      let t = { count: this.count };
      console.log("id是" + this.product_id);
      addProductToCart(this.product_id, t).then((res) => {
        if (res.success == true) {
          this.openMessage(res.message);
          this.count = 0;
        }
      });
      this.message = t.message;
    },
    opendetail() {},
  },
  props: {
    product_name: {
      type: String,
      required: true,
    },
    price: {
      type: Number,
      required: true,
    },
    product_press: {
      type: String,
      required: true,
    },
    product_type: {
      type: String,
      required: true,
    },
    seller_name: {
      type: String,
      required: true,
    },

    sell_address: {
      type: String,
      required: true,
    },
    product_id: {
      type: Number,
      required: true,
    },
    product_image: {
      type: String,
      required: true,
    },
  },
};
</script>
