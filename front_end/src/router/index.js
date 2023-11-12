import { createRouter, createWebHashHistory } from "vue-router";
import { userStore } from "@/store/user.js";

/* 页面设计 */
// 网站首页
const Home = () => import("@/views/home/index.vue");
// 登录页
const Login = () => import("@/views/personalCenter/login.vue");
// 注册页
const Register = () => import("@/views/personalCenter/register.vue");
// 个人中心
const PersonalCenter = () => import("@/views/personalCenter/index.vue");
// 购物车
const Cart = () => import("@/views/cart/index.vue");
// 商品中心
const Products = () => import("@/views/productsCenter/index.vue");
// 404页面
const Page404 = () => import("@/views/404.vue");
/* 路由定义 */
const routes = [
  {
    path: "/",
    redirect: { name: "Home" },
  },
  {
    path: "/home",
    name: "Home",
    component: Home,
  },
  {
    path: "/login",
    name: "Login",
    component: Login,
  },
  {
    path: "/register",
    name: "Register",
    component: Register,
  },
  {
    path: "/personalCenter",
    name: "PersonalCenter",
    component: PersonalCenter,
  },
  {
    path: "/cart",
    name: "Cart",
    component: Cart,
  },
  {
    path: "/products",
    name: "Products",
    component: Products,
  },
  {
    path: "/404",
    name: "404Page",
    component: Page404,
  },
];

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

// 路由守卫
router.beforeEach((to, from, next) => {
  const store = userStore();
  if (store.$token) {
    next();
  } else {
    /* 目前未添加数据库，之后补充在完成数据后添加直接跳转登录页 */
    if (routes.find((item) => item.path === to.path)) {
      next();
    } else {
      next({ name: "404Page" });
    }
  }
});

export default router;
