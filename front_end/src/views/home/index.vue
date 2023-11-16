<template>
  <div class="home">
    <div>
      <p class="home_sub">
        北&nbsp;航&nbsp;二&nbsp;手&nbsp;书&nbsp;网&nbsp;站<br>
        一个平台 帮助每一位北航人售购闲置二手书<br>
        <router-link to="/login" class="home_sub"></router-link>
      </p>
    </div>

    <div>
      <span class="arrow-icon">

      </span>
    </div>
    <br>

  </div>


  <!--快捷导航模块
   <section class="shortcut">
    <div class="w">
      <div class="fl">
        <ul>
          <li>XXX欢迎你!&nbsp;</li>
          <li>
            <router-link to="/login" style="margin-right: 5px;">登录</router-link>
            <a href="#" class="red">免费注册</a>
          </li>
        </ul>
      </div>
      <div class="fr">
        <ul>
          <li>我的订单</li>
          <li></li>
          <li>个人中心</li>
          <li></li>
          <li><router-link to="/shopping">购物车</router-link></li>
          <li></li>
          <li>
            <router-link to="/personalCenter">个人中心</router-link>
          </li>
          <li></li>
          <li>客服服务</li>
        </ul>
      </div>
    </div>
  </section> -->

  <!-- <header class="header w">
    logo模块 
    <div class="logo">
      <h1>
        <a href="index.html" title="二手书网站 ">二手书网站</a>
      </h1>
    </div>
     搜索模块 
    <div class="search">
      <input type="search" placeholder="商品名称、作者、出版社">
      <button>搜索</button>
    </div>
    购物车模块
    <div class="shopcar">
      <router-link to="/shopping">我的购物车</router-link>
      <i class="count">8</i>
    </div>
  </header> -->

  <!-- <div class="homepage">
    <h1 class="homeView w-24 text-blue-500">{{ project_title }}</h1>
    <p>
      <router-link
        to="/login"
        class="login_button w-48 font-bold text-2xl text-red-600"
        >登录</router-link>
    </p>
    <p>
      <router-link
        to="/personalCenter"
        class="register_button w-48 font-bold text-2xl text-red-600"
        >个人中心</router-link>
    </p>
  </div> -->
</template>

<style>
@import url("../../../css/base.css");
@import url("../../../css/home.css");
</style>

<script>
export default {
  data() {
    return {
      project_title: "DataBase Project",
    };
  },
};
</script>
