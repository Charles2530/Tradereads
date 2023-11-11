import { createRouter, createWebHashHistory } from "vue-router";
import { userStore } from "../store/user.js";
const routes = [
  {
    path: "/",
    name: "Home",
    component: () => import("../views/home/index.vue"),
  },
  {
    path: "/login",
    name: "Login",
    component: () => import("../views/personalCenter/login.vue"),
  },
  {
    path: "/register",
    name: "Register",
    component: () => import("../views/personalCenter/register.vue"),
  },
  {
    path: "/personalCenter",
    name: "PersonalCenter",
    component: () => import("../views/personalCenter/index.vue"),
  },
  {
    path: "/cart",
    name: "Cart",
    component: () => import("../views/cart/index.vue"),
  },
  {
    path: "/products",
    name: "Products",
    component: () => import("../views/productsCenter/index.vue"),
  },
];

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

router.beforeEach((to, from, next) => {
  const store = userStore();
  if (store.token) {
    next();
  } else {
    if (
      to.path === "/login" ||
      to.path === "/" ||
      to.path === "/register" ||
      to.path === "/personalCenter" ||
      to.path === "/products" ||
      to.path === "/cart"
    ) {
      next();
    } else {
      next("/");
    }
  }
});

export default router;
