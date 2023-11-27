<template>
  <div class="item1">
    <div class="img" :style="imgg"></div>
    <div class="seller">seller:{{ seller_name }}</div>
    <div class="price">price:￥{{ price }}</div>
    <div class="name">name:{{ product_name }}</div>
    <div class="num">sell_address:{{ sell_address }}</div>
    <div class="press">product_press:{{ product_press }}</div>
    <div class="type">product_type:{{ product_type }}</div>


    <div class="add" @click="count++">
      
    </div>
    <div class="count">{{ count }}</div>
    <div class="sub" @click="count > 0 ? count-- : count">
      
    </div>
    <div class="bought" @click="buything">
      
    </div>
  </div>
</template>

<style>
@import url("../../css/base.css");

.item1 {
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

}

.seller {
  position: absolute;
  font-size: 20px;
  top: 420px;
  left: 20px;
}

.price {
  position: absolute;
  font-size: 20px;
  top: 460px;
  left: 20px;
}

.name {
  position: absolute;
  font-size: 20px;
  top: 500px;
  left: 20px;
}

.num {
  position: absolute;
  font-size: 20px;
  top: 540px;
  left: 20px;
}

.press {
  position: absolute;
  font-size: 20px;
  top: 580px;
  left: 20px;
}

.type {
  position: absolute;
  font-size: 20px;
  top: 620px;
  left: 20px;
}

.add {
  position: absolute;
  font-family: 'icomoon';
  font-size: 20px;
  content: "\ea0a";
  top: 420px;
  right: 90px;
}

.add:hover {
  color: aqua;
  font-size: 20px;
}

.sub {
  position: absolute;
  font-family: 'icomoon';
  font-size: 20px;
  content: "\ea0b";
  top: 420px;
  right: 10px;
}

.sub:hover {
  color: aqua;
  font-size: 20px;
}

.count {
  position: absolute;
  font-size: 20px;
  top: 420px;
  right: 50px;
}

.bought {
  position: absolute;
  position: absolute;
  font-family: 'icomoon';
  font-size: 30px;
  content: "\ea11";
  top: 460px;
  right: 40px;
}

.bought:hover {
  color: aqua;
  font-size: 40px;
}
</style>

<script>

import buyProductItem from '../components/buyProductItem.vue';
import { addProductToCart } from '@/api/product.js'
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
  name: 'buyProductItem',
  data() {
    return {
      test: "2.jpg",
      count: 0,
      message: '',
      project_title: "DataBase Project",
    };
  },
  computed: {
    imgg: function () {
      return "background-image: url(../../public/" + this.product_image + ");"
    }
  },
  methods: {
    openMessage(message) {
      ElMessage({
        showClose: true,
        message: message,
        type: "success",
      });
    },
    buything() {
      let t = { count: this.count };
      console.log("id是" + this.product_id);
      addProductToCart(this.product_id, t).then(res => {

        if (res.success == true) {
          this.openMessage(res.message)
        }


      });
      this.message = t.message;
      console.log

    },
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
      type: Number,
      required: true,
    },
  },
};


</script>