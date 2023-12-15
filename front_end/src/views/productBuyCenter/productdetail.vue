<template>
    <div class="all">
        <div class="header1">
            <p>{{ product_name }}</p>
            <div class="return">
                <router-link to="/ProductBuy"></router-link>
            </div>
        </div>
        <div class="zhu">
            <div class="image" :style="imgg"></div>
            <div class="info">
                <div class="name11">{{ product_name }}</div>
                <div class="price11">价格： ￥{{ price }}</div>
                <div class="press11">出版社：{{ product_press }}</div>
                <div class="sellname11">发货人信息：{{ seller_name }} &nbsp;&nbsp;&nbsp;&nbsp; {{ seller_phone }}</div>
                <div class="capcity11">{{ product_state }}</div>
                <div class="add1" @click="count++">
                    
                </div>
                <div class="count1">{{ count }}</div>
                <div class="sub1" @click="count > 0 ? count-- : count">
                    
                </div>
                <button class="bought1" @click="buything">
                    购&nbsp;&nbsp;&nbsp;&nbsp;买
                </button>
                <button class="addbought1" @click="addshop">
                    加入购物车
                </button>
            </div>
        </div>
        <div class="comment">
            <div class="fivestar">
                <div class="star2 one1" @click="one"></div>
                <div class="star2 two1" @click="two"></div>
                <div class="star2 three1" @click="three"></div>
                <div class="star2 four1" @click="four"></div>
                <div class="star2 five1" @click="five"></div>
            </div>
            <div class="search1">
                <label for="search"></label>
                <input type="text" class="ss3" v-model="search" v-on:focus="searchfind()" v-on:blur="disappear()">
            </div>
            <button class="pushs" @click="pushcomment">发布</button>
            <div v-for="comms in comments.value" :key="comms.product_id" class="com_sub">
                <div class="comname">
                    {{ comms.user_id }}
                </div>
                <div class="commain">
                    <!-- <div class="star"></div> -->
                    <div class="star">
                        <span v-for="s in comms.score"></span>
                    </div>
                    <div class="commm">{{ comms.content }}</div>
                    <div class="date">{{ comms.date }}</div>
                </div>
            </div>
        </div>
    </div>
</template>

<style>
@import url("../../css//base.css");
@import url("../../css/shopping.css");

.header1 {
    width: 100%;
    height: 100px;
    border-radius: 40px;
}

.zhu {
    height: 600px;
    width: 100%;



}

.image {
    float: left;
    position: relative;
    height: 400px;
    width: 30%;
    background: aliceblue url(../../public/b6f14a73538b2836af10722a34e23627.jpg) no-repeat center 0px;
    top: 60px;
    left: 80px;
    background-size: contain;
}

.info {
    position: relative;
    height: 100%;
    left: 40%;

}

.name11 {
    position: absolute;
    left: 20px;
    top: 60px;
    height: 50px;
    width: 100%;
    font-size: 30px;
    font-weight: 900;
}

.price11 {
    position: absolute;
    left: 20px;
    top: 140px;
    height: 50px;
    width: 100%;
    font-size: 30px;
    font-weight: 600;
}

.press11 {
    position: absolute;
    left: 20px;
    top: 200px;
    height: 50px;
    width: 100%;
    font-size: 30px;
    font-weight: 600;
}

.sellname11 {
    position: absolute;

    left: 20px;
    top: 260px;
    height: 50px;
    width: 100%;
    font-size: 20px;

}

.capcity11 {
    position: absolute;

    left: 20px;
    top: 300px;
    height: 50px;
    width: 100%;

    font-size: 20px;
    color: rgb(195, 44, 44);
    /* background-color: hsl(0, 100%, 50%, 0.1); */
}

.add1 {
    position: absolute;
    font-family: 'icomoon';
    font-size: 20px;
    content: "\ea0a";
    top: 400px;
    left: 20px;
}

.add1:hover {
    color: aqua;
    font-size: 20px;
}

.sub1 {
    position: absolute;
    font-family: 'icomoon';
    font-size: 20px;
    content: "\ea0b";
    top: 400px;
    left: 130px;
}

.sub1:hover {
    color: aqua;
    font-size: 20px;
}

.count1 {
    position: absolute;
    font-size: 20px;
    top: 400px;
    left: 80px;
}

.bought1 {
    position: absolute;
    height: 70px;
    width: 160px;
    font-size: 30px;
    top: 400px;
    left: 480px;
    background-color: skyblue;
    border-radius: 30px;
    border: 2px solid blue;
}

.bought1:hover {
    font-size: 40px;
    background-color: aqua;
}

.addbought1 {
    position: absolute;
    height: 70px;
    width: 160px;
    font-size: 30px;
    top: 400px;
    left: 700px;
    background-color: skyblue;
    border-radius: 30px;
    border: 2px solid blue;
}

.addbought1:hover {

    background-color: aqua;
}

.comment {
    width: 100%;

}

.com_sub {
    width: 100%;
    height: 200px;
    border: 1px solid blue;
    border-radius: 30px;
    box-shadow: 10px 10px 3px rgba(141, 138, 138, 0.3);
    margin: 12px;
}

.comname {
    float: left;
    width: 30%;
    height: 100%;
    font-size: 30px;
    text-align: center;
    line-height: 100px;
}

.commain {
    float: left;
    width: 70%;
    height: 100%;


}

.star {
    color: red;
    font-family: 'icomoon';
    font-size: 30px;
    content: '\e9d9';
}

.commm {
    font-size: 30px;
}

.date {
    font-size: 15px;
    color: gray;
}

.search1 {
    position: absolute;

    top: 620px;
    width: 400px;
    right: 430px;
}

.pushs {
    position: absolute;
    width: 130px;
    height: 60px;
    top: 625px;

    right: 30px;
    font-size: 30px;
    border-radius: 20px;
    border: 2px solid blue;
    background-color: skyblue;
}

.pushs:hover {
    font-size: 40px;
    background-color: aqua;
}

.fivestar {
    position: absolute;
    float: left;
    top: 610px;
    width: 400px;
    right: 730px;
}

.star2 {
    float: left;

    font-family: 'icomoon';
    font-size: 50px;
    content: '\e9d9';
}

.ss3 {

    width: 600px;
    height: 60px;
    font-size: 35px;
    box-shadow: 0 12px 12px rgba(0, 0, 0, 0.3);
    border: 1px solid rgb(83, 71, 161);
    border-radius: 30px;
    text-align: center;
    background-color: rgb(255, 255, 255);
}
</style>

<script>

import { onMounted, ref } from 'vue'
import { showAllProducts } from '@/api/product.js'
import { addProduct } from '../../api/product'

// Open notification
import { getProduct } from '@/api/product.js'
import { showComments } from '@/api/product.js'
import { addProductToCart } from '@/api/product.js'
import { buyProduct } from '@/api/product.js'
import { addComment } from "@/api/comment.js";
export default {


    components: {

    },
    data() {
        return {
            score: 0,
            product_id: 1,
            product_image: "1.jpg",
            price: 62,
            product_name: "造现参",
            product_press: "dolor occaecat aute aliqua",
            product_state: "aliquip culpa",
            seller_name: "门达到合军处",
            seller_phone: "18684594537",
            comments: [],
            count: 0,
            search: "说说你的想法",
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
        buything() {
            let t = { count: this.count };
            console.log("id是" + this.product_id);
            buyProduct(this.product_id, t).then(res => {
                if (res.success == true) {
                    this.openMessage(res.message)
                    this.count = 0;
                }
            });
        },
        addshop() {
            let t = { count: this.count };
            console.log("id是" + this.product_id);
            addProductToCart(this.product_id, t).then(res => {
                if (res.success == true) {
                    this.openMessage(res.message)
                    this.count = 0;
                }
            });
        },
        searchfind(event) {
            this.search = "";
        },
        disappear(event) {
            if (this.search == "") {
                this.search = "说说你的看法";
            }

        },
        one() {
            const b1 = document.querySelector('.one1');
            b1.style.color = 'red'
            const b2 = document.querySelector('.two1');
            b2.style.color = 'gray'
            const b3 = document.querySelector('.three1');
            b3.style.color = 'gray'
            const b4 = document.querySelector('.four1');
            b4.style.color = 'gray'
            const b5 = document.querySelector('.five1');
            b5.style.color = 'gray'
            this.score = 1;
        },
        two() {
            const b1 = document.querySelector('.one1');
            b1.style.color = 'red'
            const b2 = document.querySelector('.two1');
            b2.style.color = 'red'
            const b3 = document.querySelector('.three1');
            b3.style.color = 'gray'
            const b4 = document.querySelector('.four1');
            b4.style.color = 'gray'
            const b5 = document.querySelector('.five1');
            b5.style.color = 'gray'
            this.score = 2;
        },
        three() {
            const b1 = document.querySelector('.one1');
            b1.style.color = 'red'
            const b2 = document.querySelector('.two1');
            b2.style.color = 'red'
            const b3 = document.querySelector('.three1');
            b3.style.color = 'red'
            const b4 = document.querySelector('.four1');
            b4.style.color = 'gray'
            const b5 = document.querySelector('.five1');
            b5.style.color = 'gray'
            this.score = 3;
        },
        four() {
            const b1 = document.querySelector('.one1');
            b1.style.color = 'red'
            const b2 = document.querySelector('.two1');
            b2.style.color = 'red'
            const b3 = document.querySelector('.three1');
            b3.style.color = 'red'
            const b4 = document.querySelector('.four1');
            b4.style.color = 'red'
            const b5 = document.querySelector('.five1');
            b5.style.color = 'gray'
            this.score = 4;
        },
        five() {
            const b1 = document.querySelector('.one1');
            b1.style.color = 'red'
            const b2 = document.querySelector('.two1');
            b2.style.color = 'red'
            const b3 = document.querySelector('.three1');
            b3.style.color = 'red'
            const b4 = document.querySelector('.four1');
            b4.style.color = 'red'
            const b5 = document.querySelector('.five1');
            b5.style.color = 'red'
            this.score = 5;
        },
        pushcomment() {
            let t = { content: this.search, score: this.score };
            console.log(t)
            console.log(this.product_id)
            addComment(this.product_id, t).then(res => {
                if (res.success == true) {
                    this.openMessage(res.message)
                    this.score = 0;
                    this.search = "说说你的看法"
                    const b1 = document.querySelector('.one1');
                    b1.style.color = 'gray'
                    const b2 = document.querySelector('.two1');
                    b2.style.color = 'gray'
                    const b3 = document.querySelector('.three1');
                    b3.style.color = 'gray'
                    const b4 = document.querySelector('.four1');
                    b4.style.color = 'gray'
                    const b5 = document.querySelector('.five1');
                    b5.style.color = 'gray'
                }
            });
        }
    },

    computed: {
        imgg: function () {
            //return "background-image: url(../../../public/" + this.product_image + ");"
            return "background-image: url(../../../public/" + "1.jpg" + ");"
        }
    },
    mounted() {
        getProduct(this.$route.params.id).then(res => {
            console.log(this.$route)
            console.log(res.data);
            this.product_id = this.$route.params.id;
            this.price = res.data.price;
            this.product_name = res.data.product_name;
            this.product_press = res.data.product_press;
            this.product_state = res.data.product_state;
            this.seller_name = res.data.seller_name;
            this.seller_phone = res.data.seller_phone;
            this.product_image = res.data.product_image;
        });
        showComments(this.$route.params.id).then(res => {
            console.log(res.data.comments)
            this.comments.value = res.data.comments;

        });
    }
};
</script>
