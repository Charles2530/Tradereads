<template>
  <div class="flex justify-center items-center">
    <h1 class="text-grey text-4xl font-semibold">
      {{ loginInfo.user_name }}的个人中心
    </h1>
  </div>
  <el-divider></el-divider>
  <div class="mb-8">
    <el-card class="box-card justify-center">
      <el-row>
        <el-col :span="1">
          <div class="user-icon info-item mt-1">
            <el-icon style="color: grey"><User /></el-icon>
          </div>
          <div class="phone-icon info-item mt-3">
            <el-icon style="color: rgba(0, 0, 255, 0.426)"
              ><Cellphone
            /></el-icon>
          </div>
          <div class="address-icon info-item mt-3">
            <el-icon style="color: grey"><Location /></el-icon>
          </div>
          <div class="gender-icon info-item mt-3">
            <el-icon style="color: rgba(0, 0, 255, 0.426)"><Male /></el-icon>
          </div>
          <div class="pay_type-icon info-item mt-3">
            <el-icon style="color: grey"><Money /></el-icon>
          </div>
          <div class="isRight-icon info-item mt-3">
            <el-icon style="color: rgba(0, 0, 255, 0.426)"><Check /></el-icon>
          </div>
        </el-col>
        <el-col :span="14">
          <div class="user info-item">
            <strong>用户名:</strong> {{ loginInfo.user_name }}
          </div>
          <div class="phone info-item">
            <strong>用户电话:</strong> {{ loginInfo.phone }}
          </div>
          <div class="address info-item">
            <strong>用户地址:</strong> {{ loginInfo.buy_address }}
          </div>
          <div class="gender info-item">
            <strong>性别:</strong> {{ loginInfo.gender }}
          </div>
          <div class="pay_type info-item">
            <strong>支付方式:</strong> {{ loginInfo.pay_type }}
          </div>
          <div class="isRight info-item">
            <strong>身份:</strong>
            {{ loginInfo.right === 1 ? "管理员" : "用户" }}
          </div>
        </el-col>
        <el-col :span="9" class="float-right">
          <div>
            <img
              :src="loginInfo.avatar"
              class="my-avatar rounded-full mb-3"
              alt="avatar"
            />
          </div>
          <!-- 商品列表展开按钮 -->
          <div class="mb-4 mx-6">
            <el-button
              type="success"
              class="text-white font-semibold hover:underline"
              @click="openProductDialog"
              plain
            >
              <el-icon class="ml-1 mr-4"><Reading /></el-icon>
              点我查看商品上新
            </el-button>
          </div>
        </el-col>
      </el-row>
    </el-card>
  </div>

  <el-dialog v-model="showProductDialog" title="我的商品列表" width="80%">
    <div v-if="products.length === 0" class="text-center">
      <el-text type="warning">暂无销售商品</el-text>
    </div>
    <div v-else>
      <div class="bg-gray-600/80 p-4 rounded-lg shadow-md product-container">
        <product-item-read
          v-for="product in products"
          :key="product.product_id"
          :product="product"
        ></product-item-read>
      </div>
    </div>
  </el-dialog>
</template>

<script>
import { ref, onMounted, reactive } from "vue";
import { getUser } from "@/api/user.js";
import { useRouter } from "vue-router";
import { showProductsList } from "@/api/product.js";
import ProductItemRead from "@c/product/ProductItemRead.vue";
export default {
  name: "followDetailInfo",
  props: {
    user_id: {
      type: Number,
      require: true,
    },
  },

  setup(props) {
    // Lifecycle hook
    onMounted(() => {
      createdUserInformation();
    });
    const products = ref([]);
    const showProductDialog = ref(false);
    const openProductDialog = () => {
      showProductsList(props.user_id).then((res) => {
        if (res.success) {
          products.value = res.data.products;
          showProductDialog.value = true;
        } else {
          ElMessage({
            showClose: true,
            message: res.message,
            type: "error",
          });
        }
      });
    };

    // Reactive state
    const loginInfo = reactive({
      phone: "",
      user_name: "",
      buy_address: "",
      gender: "",
      pay_type: "",
      right: "",
      avatar: "",
    });

    const router = useRouter();

    // Methods

    const createdUserInformation = () => {
      getUser(props.user_id)
        .then((res) => {
          console.log(res);
          if (res.success) {
            loginInfo.phone = res.data.phone;
            loginInfo.user_name = res.data.user_name;
            loginInfo.buy_address = res.data.buy_address;
            loginInfo.gender = res.data.gender;
            loginInfo.pay_type = res.data.pay_type;
            loginInfo.right = res.data.right;
            loginInfo.avatar = res.data.avatar;
          } else {
            ElMessage({
              showClose: true,
              message: "获取用户信息失败，请重新登录",
              type: "error",
            });
            router.push("/login");
          }
        })
        .catch((err) => {
          console.log(err);
        });
    };

    return {
      loginInfo,
      products,
      showProductDialog,
      openProductDialog,
      ProductItemRead,
    };
  },
};
</script>

<style scoped>
.box-card {
  margin-bottom: 20px;
  border-radius: 10px;
}
.button-container {
  display: flex;
}
.my-avatar {
  cursor: pointer;
  width: 218px;
  height: 218px;
  border-radius: 50%;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.7);
}
.my-avatar:hover {
  opacity: 0.7;
  transform: scale(1.1);
}

.info-item {
  font-size: 1.4rem;
  color: #333;
  margin-bottom: 15px;
}
.product-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}
</style>
