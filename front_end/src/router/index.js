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
    component: () => import("../views/login.vue"),
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
    if (to.path === "/login" || to.path === "/") {
      next();
    } else {
      next("/");
    }
  }
});

export default router;
