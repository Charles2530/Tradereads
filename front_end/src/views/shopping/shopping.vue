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
        <div class="main">
            <div class="header">
                <p>我的购物车</p>
                <div class="return">
                    <router-link to="/personalCenter"></router-link>
                </div>
            </div>
            <div class="button">

                <shopping-item v-for="shoppinglist in shoopingUser.value" :key="shoppinglist.product_id"
                    :seller_name="shoppinglist.seller_name" :product_name="shoppinglist.product_name"
                    :product_number="shoppinglist.product_number" :product_price="shoppinglist.product_price"
                    :product_image="shoppinglist.product_image">
                </shopping-item>


                <!-- {{ shoopingUser.data.total_price }} -->
                <p class="money">商品总额：￥{{ total }}</p>
                <button class="generate" @click="generate()"></button>
            </div>

        </div>
    </div>
</template>

<style>
@import url("../../css/base.css");
@import url("../../css/shopping.css");
</style>

<script>

import shoppingItem from '../../components/shoppingItem.vue';
import { onMounted, ref } from 'vue'
import { showCurrentUserCart, addCartsToOrders } from '@/api/cart.js'
export default {
    components: {
        'shooping-item': shoppingItem
    },
    data() {
        return {
            total: "",
            shoopingUser: [],
            project_title: "DataBase Project",
        };
    },
    methods: {
        generate(event) {
            addCartsToOrders();
            location.reload();
        },
        updataData(data) {
 
        }
    },
    mounted() {
        console.log(1);
        showCurrentUserCart().then(res => {
            console.log(res.data);
            this.shoopingUser.value = res.data.products;
            this.total = res.data.total_price;
            console.log(this.total)
            console.log(this.shoopingUser.value);
            console.log(this.shoopingUser.value[0].product_id);

        });

    }
};
</script>
