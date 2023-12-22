<template>
  <div>
    <div class="flex justify-center items-center">
      <h1 class="text-white text-4xl font-semibold">个人中心</h1>
    </div>
    <el-divider></el-divider>
    <div class="mb-8">
      <h2 class="text-white text-2xl font-semibold mb-4">个人信息</h2>
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
            <img
              :src="loginInfo.avatar"
              class="my-avatar rounded-full mb-3"
              alt="avatar"
            />
            <personal-avatar-upload />
          </el-col>
        </el-row>
      </el-card>
    </div>
    <!-- 修改个人信息弹窗 -->
    <div class="button-container">
      <div>
        <div class="mb-4 mx-2">
          <el-button
            type="info"
            class="text-white font-semibold hover:underline"
            @click="personalMessageInfo"
            plain
          >
            <el-icon class="ml-1 mr-4"><ChatLineRound /></el-icon>
            修改个人信息
          </el-button>
        </div>
        <el-dialog v-model="openUserInformation" width="25%">
          <div>
            <el-text class="mx-1 mb-4" type="success"
              >请修改你的用户信息!</el-text
            >
            <div class="mt-2">
              <el-text class="mx-1" type="info">新用户名</el-text>
              <el-input
                v-model="new_username"
                class="my-2"
                placeholder="新用户名"
                autocomplete="on"
                clearable
              ></el-input>
              <el-text class="mx-1" type="info">新购买地址</el-text>
              <el-input
                v-model="new_address"
                placeholder="新购买地址"
                autocomplete="on"
                clearable
              ></el-input>
            </div>
          </div>
          <template v-slot:footer>
            <div style="display: flex; justify-content: space-between">
              <el-button @click="openUserInformation = false">取 消</el-button>
              <el-button type="primary" @click="updateUserInfo"
                >确 定</el-button
              >
            </div>
          </template>
        </el-dialog>
      </div>
      <!-- 修改用户密码弹窗 -->
      <div class="mb-4">
        <el-button
          type="warning"
          class="text-white font-semibold hover:underline"
          @click="openUserPassword = true"
          plain
        >
          <el-icon class="ml-1 mr-4"><Unlock /></el-icon>
          修改用户密码
        </el-button>
      </div>
      <el-dialog v-model="openUserPassword" width="25%">
        <div>
          <el-text class="mx-1 mb-4" type="success">请修改你的密码!</el-text>
          <el-input
            v-model="old_password"
            placeholder="请输入旧密码"
            clearable
            class="my-2"
          ></el-input>
          <el-input
            v-model="new_password"
            placeholder="新密码"
            clearable
          ></el-input>
        </div>
        <template v-slot:footer>
          <div style="display: flex; justify-content: space-between">
            <el-button @click="openUserPassword = false">取 消</el-button>
            <el-button type="primary" @click="updateUserPasswordInfo"
              >确 定</el-button
            >
          </div>
        </template>
      </el-dialog>
    </div>
  </div>
</template>

<script>
import { ref, onMounted, reactive } from "vue";
import {
  getUser,
  modify_username,
  modify_address,
  modify_password,
} from "@/api/user.js";
import { userStore } from "@/store/user.js";
import { useRouter } from "vue-router";
export default {
  name: "personalInfo",

  setup() {
    // Lifecycle hook
    onMounted(() => {
      createdUserInformation();
    });

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

    const store = userStore();
    const router = useRouter();

    const openUserInformation = ref(false);
    const openUserPassword = ref(false);
    const new_username = ref("");
    const new_address = ref("");
    const old_password = ref("");
    const new_password = ref("");

    // Methods
    const personalMessageInfo = () => {
      openUserInformation.value = true;
      new_username.value = loginInfo.user_name;
      new_address.value = loginInfo.buy_address;
    };

    const createdUserInformation = () => {
      getUser(store.getToken)
        .then((res) => {
          console.log("token:" + store.getToken);
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

    const updateUserInfo = () => {
      openUserInformation.value = false;
      updateUserAddress();
      updateUserName();
    };

    const updateUserPasswordInfo = () => {
      openUserPassword.value = false;
      updateUserPassword();
    };

    const updateUserName = () => {
      modify_username(store.getToken, {
        new_username: new_username.value,
      })
        .then((res) => {
          if (res.success) {
            loginInfo.user_name = new_username.value;
            ElMessage({ message: res.message, type: "success" });
          } else {
            ElMessage({ message: res.message, type: "error" });
          }
        })
        .catch((err) => {
          console.error(err);
        });
    };

    const updateUserAddress = () => {
      modify_address(store.getToken, {
        new_address: new_address.value,
      })
        .then((res) => {
          if (res.success) {
            loginInfo.buy_address = new_address.value;
            ElMessage({ message: res.message, type: "success" });
          } else {
            ElMessage({ message: res.message, type: "error" });
          }
        })
        .catch((err) => {
          console.error(err);
        });
    };

    const updateUserPassword = () => {
      modify_password(store.getToken, {
        old_password: old_password.value,
        new_password: new_password.value,
      })
        .then((res) => {
          if (res.success) {
            ElMessage({ message: res.message, type: "success" });
          } else {
            ElMessage({ message: res.message, type: "error" });
          }
        })
        .catch((err) => {
          console.error(err);
        });
    };

    return {
      loginInfo,
      openUserInformation,
      openUserPassword,
      new_username,
      new_address,
      old_password,
      new_password,
      updateUserInfo,
      updateUserPasswordInfo,
      personalMessageInfo,
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
</style>
