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
// 404页面
const Page404 = () => import("@/views/404.vue");
// 订单管理页面
const OrdersManagement = () => import("@/views/admin/userOrderManagement.vue");
// 审核订单页面
const CheckOrdersView = () => import("@/views/admin/checkOrdersView.vue");
// 用户管理页面
const UsersManagement = () => import("@/views/admin/UsersManagement.vue");
// 公告栏
const Notice = () => import("@/views/notice/index.vue");
// 关注用户详情页
const FollowDetail = () => import("@/views/personalCenter/followDetail.vue");
// 购物车页面
const Shopping = () => import("@/views/shopping/index.vue");
// 商品购买中心
const ProductBuy = () => import("@/views/productBuyCenter/index.vue");
// 我的商品
const DeveloperInfo = () => import("@/views/admin/DeveloperInfo.vue");
// 商品详情界面
const ProductDetail = () =>
  import("@/views/productBuyCenter/productDetail.vue");
// 商品排行榜
const RankingList = () => import("@/views/productBuyCenter/rankingList.vue");
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
    path: "/404",
    name: "404Page",
    component: Page404,
  },
  {
    path: "/ordersManagement",
    name: "OrdersManagement",
    component: OrdersManagement,
  },
  {
    path: "/checkOrdersView",
    name: "CheckOrdersView",
    component: CheckOrdersView,
  },
  {
    path: "/usersManagement",
    name: "UsersManagement",
    component: UsersManagement,
  },
  {
    path: "/notice",
    name: "Notice",
    component: Notice,
  },
  {
    path: "/followDetail/:user_id",
    name: "FollowDetail",
    component: FollowDetail,
    props: true,
  },
  {
    path: "/shopping",
    name: "Shopping",
    component: Shopping,
  },
  {
    path: "/ProductBuy",
    name: "ProductBuy",
    component: ProductBuy,
  },
  {
    path: "/DeveloperInfo",
    name: "DeveloperInfo",
    component: DeveloperInfo,
  },
  {
    path: "/ProductDetail/:product_id",
    name: "ProductDetail",
    component: ProductDetail,
    props: true,
  },
  {
    path: "/rankingList",
    name: "RankingList",
    component: RankingList,
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
    console.log(to.path);
    if (
      routes.some((item) =>
        new RegExp("^" + item.path.split("/:")[0] + "(?:/.*)?$").test(to.path)
      )
    ) {
      next();
    } else {
      next({ name: "404Page" });
    }
  }
});

export default router;
