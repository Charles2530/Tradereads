<template>
  <div class="all">
    <div class="sidebar" id="root">
      <div class="icon one">
        <router-link to="/personalCenter"></router-link>
      </div>
      <div class="icon two">
        <router-link to="/ProductBuy"></router-link>
      </div>
      <div class="icon three">
        <router-link to="/shopping"></router-link>
      </div>
      <div class="icon four">
        <router-link to="/404"></router-link>
      </div>
      <div class="icon five">
        <router-link to="/404"></router-link>
      </div>
    </div>
    <div class="main" :style="onehidden">
      <div class="header">
        <p>商品中心</p>
        <div class="return">
          <router-link to="/personalCenter"></router-link>
        </div>
      </div>
      <div class="button">
        <buyProductItem
          v-for="shoppinglist in shoopingUser.value"
          :key="shoppinglist.product_id"
          :product_id="shoppinglist.product_id"
          :product_name="shoppinglist.product_name"
          :price="shoppinglist.price"
          :product_press="shoppinglist.product_press"
          :seller_name="shoppinglist.seller_name"
          :sell_address="shoppinglist.sell_address"
          :product_type="shoppinglist.product_type"
          :product_image="shoppinglist.product_image"
        >
        </buyProductItem>
      </div>
    </div>
    <button class="generate" @click="generate()"></button>
    <div class="submit" :style="twohidden">
      <div class="up">
        <div class="total">
          <label for="price">price</label>
          <input
            type="text"
            style="font-size: 20px"
            v-model="price"
            id="price"
            autocomplete="off"
          />
        </div>
        <div class="total">
          <label for="sell_address">address</label>
          <input
            type="text"
            style="font-size: 20px"
            v-model="sell_address"
            id="sell_address"
            autocomplete="off"
          />
        </div>
        <div class="total">
          <label for="store">store</label>
          <input
            type="text"
            style="font-size: 20px"
            v-model="store"
            id="store"
            autocomplete="off"
          />
        </div>
        <div class="total">
          <label for="product_name">name</label>
          <input
            type="text"
            style="font-size: 20px"
            v-model="product_name"
            id="product_name"
            autocomplete="off"
          />
        </div>
        <div class="total">
          <label for="number">image</label>
          <input
            type="text"
            style="font-size: 20px"
            v-model="product_image"
            id="number"
            autocomplete="off"
          />
        </div>
        <div class="total">
          <label for="product_press">press</label>
          <input
            type="text"
            style="font-size: 20px"
            v-model="product_press"
            id="product_press"
            autocomplete="off"
          />
        </div>
        <div class="total">
          <label for="product_type">type</label>
          <input
            type="text"
            style="font-size: 20px"
            v-model="product_type"
            id="product_type"
            autocomplete="off"
          />
        </div>
        <div class="and">
          <button class="left" @click="cancel()">取消</button>
          <button class="right" @click="comfirm()">确定</button>
        </div>
      </div>
    </div>
  </div>
</template>

<style>
@import url("../../../css/base.css");
@import url("../../../css/productBuy.css");
@import url("../../../css/shopping.css");

.generate {
  position: fixed;
  font-family: "icomoon";
  font-size: 50px;
  content: "\ea52";
  bottom: 80px;
  right: 100px;
}

.generate:hover {
  font-size: 60px;
  color: aqua;
}

.left {
  position: fixed;
  bottom: 40px;
  left: 40%;
  background-color: rgb(204, 204, 231);
  margin-left: 120px;
}

.left:hover {
  font-size: 40px;
  color: aqua;
}

.right {
  position: fixed;
  bottom: 40px;
  left: 60%;
  background-color: rgb(204, 204, 231);
  margin-left: 100px;
}

.right:hover {
  font-size: 40px;
  color: aqua;
}

.submit {
  position: fixed;
  width: 100%;
  height: 100%;
  background: rgb(66, 57, 57, 0.6) no-repeat;
}

.up {
  margin-top: 100px;
  text-align: right;
}

.total {
  margin: 10px 40%;

  font-size: 30px;
  color: rgb(13, 18, 18);
}

input {
  width: 600px;
  border: 1px solid rgb(21, 11, 87);
  border-radius: 30px;
  background-color: antiquewhite;
}

.and {
  margin: 10px 40%;

  font-size: 30px;
  color: rgb(13, 18, 18);
}

input {
  background-color: antiquewhite;
  text-align: center;
}
</style>

<script>
import buyProductItem from "../../components/buyProductItem.vue";
import { onMounted, ref } from "vue";
import { showAllProducts } from "@/api/product.js";
import { addProduct } from "../../api/product";

// Open notification

export default {
  components: {
    "shooping-item": buyProductItem,
  },
  data() {
    return {
      price: "请输入价格（请输入实数）",
      sell_address: "请输入发货地址",
      store: "请输入库存（请输入正整数）",
      product_name: "请输入商品名",
      product_image: "请输入照片地址（请输入 1.jpg / 2.jpg / 3.jpg / 4.jpg）",
      product_press: "请输入出版社地址",
      product_type: "请输入书类（请输入 art/math/literature/history/novel）",
      onehidden: "visibility:visible",
      twohidden: "visibility:hidden",
      total: "",
      shoopingUser: [],
      project_title: "DataBase Project",
    };
  },
  methods: {
    openMessage(message) {
      ElMessage({
        showClose: true,
        message: message,
        type: "success",
      });
    },
    generate(event) {
      this.onehidden = "visibility:hidden";
      this.twohidden = "visibility:visible";
    },
    cancel(event) {
      this.onehidden = "visibility:visible";
      this.twohidden = "visibility:hidden";
    },
    comfirm(event) {
      this.onehidden = "visibility:visible";
      this.twohidden = "visibility:hidden";
      let t = {
        price: this.price,
        sell_address: this.sell_address,
        store: this.store,
        product_name: this.product_name,
        product_image: this.product_image,
        product_press: this.product_press,
        product_type: this.product_type,
      };

      addProduct(t).then((res) => {
        console.log(res);
        if (res.success == true) {
          this.openMessage(res.message);
          showAllProducts().then((res) => {
            console.log(res.data);
            this.shoopingUser.value = res.data.products;
            console.log(this.shoopingUser.value);
            console.log(this.shoopingUser.value[0].product_id);
          });
          location.reload();
        }
      });
    },
  },
  mounted() {
    showAllProducts().then((res) => {
      console.log(res.data);
      this.shoopingUser.value = res.data.products;
      console.log(this.shoopingUser.value);
      console.log(this.shoopingUser.value[0].product_id);
    });
  },
};
</script>
