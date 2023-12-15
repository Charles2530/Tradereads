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
        <router-link to="/Search"></router-link>
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
        <div class="select">
          <select v-model="selectedProvince" class="ses" v-on:click="sort()">
            <option value="" disabled selected>筛选</option>
            <option v-for="province in provinces" :value="province.name" style="border:1px solid black;">{{ province.name
            }}</option>
          </select>
        </div>
        <div class="select3">
          <select v-model="follow" class="ses3" v-on:click="sortfollow()">
            <option v-for="province in follows" :value="province.name" style="border:1px solid black;">{{ province.name
            }}</option>
          </select>
        </div>

      </div>
      <div class="button">
        <buyProductItem v-for="shoppinglist in shoopingUser.value" :key="shoppinglist.product_id"
          :product_id="shoppinglist.product_id" :product_name="shoppinglist.product_name" :price="parseInt(shoppinglist.price)"
          :product_press="shoppinglist.product_press" :seller_name="shoppinglist.seller_name"
          :sell_address="shoppinglist.sell_address" :product_type="shoppinglist.product_type"
          :product_image="shoppinglist.product_image">
        </buyProductItem>
      </div>

    </div>
    <button class="generate" @click="generate()"></button>
    <div class="submit" :style="twohidden">
      <div class="up">
        <div class="total">
          <label for="price">price</label>
          <input type="text" style="font-size: 20px" v-model="price" id="price" autocomplete="off" />
        </div>
        <div class="total">
          <label for="sell_address">address</label>
          <input type="text" style="font-size: 20px" v-model="sell_address" id="sell_address" autocomplete="off" />
        </div>
        <div class="total">
          <label for="store">store</label>
          <input type="text" style="font-size: 20px" v-model="store" id="store" autocomplete="off" />
        </div>
        <div class="total">
          <label for="product_name">name</label>
          <input type="text" style="font-size: 20px" v-model="product_name" id="product_name" autocomplete="off" />
        </div>
        <div class="total">
          <label for="number">image</label>
          <input type="text" style="font-size: 20px" v-model="product_image" id="number" autocomplete="off" />
        </div>
        <div class="total">
          <label for="product_press">press</label>
          <input type="text" style="font-size: 20px" v-model="product_press" id="product_press" autocomplete="off" />
        </div>
        <div class="total">
          <label for="product_type">type</label>
          <input type="text" style="font-size: 20px" v-model="product_type" id="product_type" autocomplete="off" />
        </div>
        <div class="and">
          <button class="left" @click="cancel()">
            取消
          </button>
          <button class="right" @click="comfirm()">
            确定
          </button>
        </div>
      </div>

    </div>
  </div>
</template>

<style>
@import url("../../css//base.css");
@import url("../../css/productBuy.css");
@import url("../../css/shopping.css");

.generate {
  position: fixed;
  font-family: 'icomoon';
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

.select {
  position: absolute;
  float: left;
  top: 20px;
  width: 400px;
  right: 70px;
  font-family: 'icomoon';
  font-size: 20px;
  content: "\e9a1";
}

.select3 {
  position: absolute;
  float: left;
  top: 20px;
  width: 400px;
  right: -100px;
  font-family: 'icomoon';
  font-size: 20px;
  content: "\e9a1";
}

.ses {
  width: 140px;
  height: 60px;
  font-size: 35px;
  box-shadow: 0 12px 12px rgba(0, 0, 0, 0.3);
  border: 1px solid rgb(83, 71, 161);
  border-radius: 30px;
  text-align: center;
}

.ses3 {
  width: 200px;
  height: 60px;
  font-size: 35px;
  box-shadow: 0 12px 12px rgba(0, 0, 0, 0.3);
  border: 1px solid rgb(83, 71, 161);
  border-radius: 30px;
  text-align: center;
}

.select option {
  display: block;
  border: 10px solid skyblue;

}
</style>

<script>
import buyProductItem from '../../components/buyProductItem.vue';
import { onMounted, ref } from 'vue'
import { showAllProducts } from '@/api/product.js'
import { addProduct } from '../../api/product'

// Open notification

export default {


  components: {
    'shooping-item': buyProductItem
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
      provinces: [
        { name: '默认', cities: ['null'] },

        { name: ' 价 格 ⬆', cities: ['北京市'] },

        { name: '好评率⬆', cities: ['上海市'] },

        { name: '评论数⬆', cities: ['广州市', '深圳市', '珠海市'] },
        { name: ' 类 型 ⬆', cities: ['广州市', '深圳市', '珠海市'] },

        // 其他省份...

      ],
      follows: [
        { name: "全部显示" },
        { name: "已关注" },
      ],
      selectedProvince: '',
      follow: '全部显示',
      show_order_base: '',
      show_order: '',
      followapp: 0,
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
      }

      addProduct(t).then(res => {
        console.log(res);
        if (res.success == true) {
          this.openMessage(res.message);
          showAllProducts().then(res => {
            console.log(res.data);
            this.shoopingUser.value = res.data.products;
            console.log(this.shoopingUser.value);
            console.log(this.shoopingUser.value[0].product_id);

          });
          location.reload();
        }

      });
    },
    sort(event) {

      if (this.selectedProvince != '') {
        console.log(11)
        for (let i = 0; i < this.provinces.length; i++) {
          if (this.selectedProvince == "默认") {
            break;
          }
          if (this.selectedProvince == this.provinces[i].name && this.selectedProvince != "默认") {
            if (this.provinces[i].name.substring(0, this.provinces[i].name.length - 1) == " 价 格 ") {
              this.show_order_base = 'price'
            } else if (this.provinces[i].name.substring(0, this.provinces[i].name.length - 1) == "评论数") {
              this.show_order_base = 'comment'
            } else if (this.provinces[i].name.substring(0, this.provinces[i].name.length - 1) == "好评率") {
              this.show_order_base = 'score'
            }
            if (this.provinces[i].name.charAt(this.provinces[i].name.length - 1) == "⬆") {
              this.provinces[i].name = this.provinces[i].name.substring(0, this.provinces[i].name.length - 1) + "⬇"
              this.show_order = 'ASC';
            } else {
              this.provinces[i].name = this.provinces[i].name.substring(0, this.provinces[i].name.length - 1) + "⬆"
              this.show_order = 'DESC';
            }
            break;
          }
        }
        showAllProducts({ "show_following": this.followapp, "show_order_base": this.show_order_base, "show_order": this.show_order }).then(res => {
          this.shoopingUser.value = res.data.products;
        });
      }
      this.selectedProvince = '';
    },
    sortfollow() {
      if (this.follow == "全部显示") {
        this.followapp = 0
      } else {
        this.followapp = 1
      }
      showAllProducts({ "show_following": this.followapp, "show_order_base": this.show_order_base, "show_order": this.show_order }).then(res => {
        this.shoopingUser.value = res.data.products;
      });
    }

  },
  mounted() {
    showAllProducts({ "show_following": 0, "show_order_base": '', "show_order": '' }).then(res => {
      console.log(res.data);
      this.shoopingUser.value = res.data.products;
      console.log(this.shoopingUser.value);
      console.log(this.shoopingUser.value[0].product_id);

    });

  }
};
</script>
