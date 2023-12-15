<template>
  <div class="item11">
    <div>
      <div class="img1" :style="imgg"></div>
    </div>

    <div class="seller1">
      <span class="bold">
        卖家:
      </span>
      {{ seller_name }}
    </div>
    <div class="price1">
      <span class="bold">
        价格:
      </span>
      ￥{{ product_price }}
    </div>
    <div class="name1">
      <span class="bold">
        书名:
      </span>
      {{ product_name }}
    </div>
    <div class="num1">
      <span class="bold">
        数量:
      </span>
      {{ product_number }}
    </div>




  </div>
</template>

<style>
@import url("../css/base.css");

.item11 {
  position: relative;
  float: left;
  width: 45%;
  height: 300px;
  margin: 14px;
  border-radius: 40px;
  background-size: 300px;
  border: 1px solid blue;
  border-radius: 30px;
  box-shadow: 10px 10px 3px rgba(141, 138, 138, 0.3);
}



.bold {
  font-weight: bold;
}

.img1 {
  position: absolute;
  height: 290px;
  width: 50%;
  background: aliceblue url(../../public/b6f14a73538b2836af10722a34e23627.jpg) no-repeat center 0px;
  top: 2px;
  background-size: contain;
  border-radius: 30px;

}

.seller1 {
  position: absolute;
  font-size: 25px;
  top: 2px;
  left: 55%;
  line-height: 30px;
}

.price1 {
  position: absolute;
  font-size: 25px;
  top: 60px;
  left: 55%;
  line-height: 30px;
}

.name1 {
  position: absolute;
  font-size: 25px;
  top: 120px;
  left: 55%;
  line-height: 30px;
}

.num1 {
  position: absolute;
  font-size: 25px;
  top: 180px;
  left: 55%;
  line-height: 30px;
}
</style>

<script>


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
      // return "background-image: url(../../public/" + "4.jpg" + ");"
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