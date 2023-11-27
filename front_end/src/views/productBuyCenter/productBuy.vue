<template>
  <div class="all">
    <div class="sidebar" id="root">
            <div class="icon one">
              <router-link to="/personalCenter"></router-link>
              
            </div>
            <div class="icon two"></div>
            <div class="icon three">
                <router-link to="/shopping"></router-link>
            </div>
            <div class="icon four">
              <router-link to="/404"></router-link>
            </div>
            <div class="icon five">
                <router-link to="/ProductBuy"></router-link>
            </div>
        </div>
      <div class="main">
          <div class="header">
              <p>商品中心</p>
              <div class="return">
                <router-link to="/personalCenter"></router-link>
                  
              </div>
          </div>
          <div class="button">
              <buyProductItem v-for="shoppinglist in shoopingUser.value" 
                      :key="shoppinglist.product_id"
                      :product_id = "shoppinglist.product_id"
                      :product_name = "shoppinglist.product_name"
                      :price = "shoppinglist.price"
                      :product_press = "shoppinglist.product_press"
                      :seller_name = "shoppinglist.seller_name"
                      :sell_address = "shoppinglist.sell_address"
                      :product_type = "shoppinglist.product_type"
                      
                      >
              </buyProductItem>
          </div>

      </div>
      <button class="generate" @click="generate()"></button>
  </div>
</template>

<style>
@import url("../../../css/base.css");
@import url("../../../css/productBuy.css");
@import url("../../../css/shopping.css");
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
</style>

<script>
import buyProductItem from '../../components/buyProductItem.vue';
import {onMounted,ref} from 'vue'
import {showAllProducts} from '@/api/product.js'


// Open notification

export default {
    

    components: {
        'shooping-item': buyProductItem
    },
    data() {
        return {
            total:"",
            shoopingUser: [],
            project_title: "DataBase Project",
        };
    },
    methods: {
      generate(event) {
        var input1 = prompt("请输入第一个值：");
        var input2 = prompt("请输入第二个值：");
      },
    },
    mounted(){
      
      showAllProducts().then(res=>{
        console.log(res.data);
        this.shoopingUser.value=res.data.products;
        console.log(this.shoopingUser.value);
        console.log(this.shoopingUser.value[0].product_id);
        
      });
      
    }
};
</script>
