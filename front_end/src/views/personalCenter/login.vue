<template>
  <div
    class="min-h-screen bg-login-background bg-cover bg-center bg-no-repeat flex justify-end items-center p-10"
  >
    <div class="w-full max-w-xs bg-white p-8 rounded shadow-lg">
      <div class="mb-4">
        <logo-info />
      </div>
      <h1
        class="login_container text-2xl font-bold mb-6 bg-blue-500 text-white p-3 rounded text-center"
      >
        用户登录<el-icon class="text-cyan-400"><User /></el-icon>
      </h1>
      <form class="login__form space-y-4">
        <div>
          <el-input
            class="w-full p-2 border rounded border-gray-300 focus:outline-none focus:border-blue-500"
            v-model="phone"
            placeholder="Phone"
            clearable
          />
        </div>
        <div>
          <el-input
            v-model="password"
            class="w-full p-2 border rounded border-gray-300 focus:outline-none focus:border-blue-500"
            type="password"
            placeholder="Password"
            show-password
          />
        </div>
        <div>
          <el-text class="mx-1" size="small" type="warning"
            >登录表明您已经同意
            <span class="notice-detail" @click="dialogVisible = true"
              >《服务条款》</span
            >
          </el-text>
        </div>
        <button
          type="submit"
          class="w-full bg-blue-500 text-white p-2 rounded hover:bg-blue-600 focus:outline-none"
          @click.prevent="Login"
        >
          立即登录
        </button>
        <router-link
          to="/register"
          class="inline-block mt-4 register-line text-zinc-500"
          style="font-size: 1px"
          >没有账号?点击注册!</router-link
        >
      </form>
    </div>
  </div>
  <div>
    <el-dialog v-model="dialogVisible" width="60%">
      <div>
        <div class="mb-4">
          <logo-info />
        </div>
        <p class="text-2xl text-center mb-4">服务条款</p>
        <p>欢迎使用Traderead！</p>
        <p>请仔细阅读以下服务条款：</p>
        <ul>
          <li class="list-node">
            条款1: 通过使用本服务，您同意遵守所有适用的法律和法规。
          </li>
          <li class="list-node">
            条款2:
            您同意不滥用本服务，包括但不限于不进行恶意行为、不侵犯他人权益。
          </li>
          <li class="list-node">
            条款3: 我们保留随时更改或终止服务的权利，恕不另行通知。
          </li>
          <li class="list-node">
            条款4: 本服务可能包含第三方提供的内容，其内容由提供者独立控制。
          </li>
        </ul>
      </div>
      <span class="dialog-footer">
        <el-button @click="dialogVisible = false">关闭</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { ref } from "vue";
import { userStore } from "@/store/user.js"; // Make sure the path is correct
import { useRouter } from "vue-router";
import { loginUser } from "@/api/user.js";
import logoInfo from "@c/home/logoInfo.vue";

export default {
  components: { logoInfo },
  setup() {
    // Reactive state properties
    const phone = ref("");
    const password = ref("");
    const dialogVisible = ref(false);

    // Store and Router instances
    const store = userStore();
    const router = useRouter();

    // Login method
    const Login = () => {
      const userInfo = {
        phone: phone.value,
        password: password.value,
      };
      loginUser(userInfo).then((res) => {
        console.log(res);
        if (res.success) {
          ElMessage({
            showClose: true,
            message: res.message,
            type: "success",
          });
          store.setUserInfo({
            token: res.data.user_id,
            right: res.data.right,
          });
          router.push("/personalCenter");
        } else {
          ElMessage({
            showClose: true,
            message: res.message,
            type: "error",
          });
        }
      });
    };

    // Open notification
    const open = () => {
      ElMessage({
        showClose: true,
        message: "登录成功",
        type: "success",
      });
    };

    // Return the reactive state and methods to the template
    return {
      phone,
      password,
      Login,
      open,
      dialogVisible,
    };
  },
};
</script>

<style>
.notice-detail {
  color: hsl(24, 91%, 49%) !important;
  cursor: pointer;
  text-decoration: underline;
}
.notice-detail:hover {
  color: #409eff !important;
  text-decoration: underline;
}
.el-dialog__header {
  padding: 0px !important;
}
.list-node {
  margin-bottom: 2px;
  color: grey;
}
.register-line:hover {
  color: rgb(220 38 38) !important;
  text-decoration: underline;
}
</style>
