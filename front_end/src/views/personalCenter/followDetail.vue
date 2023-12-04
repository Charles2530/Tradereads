<template>
  <div>
    <div>
      <section class="shortcut">
        <div class="w fixed left-28">
          <ul>
            <li style="color: #ffd04b; border-radius: 5px">
              Welcome to Tradereads!&nbsp;
            </li>
          </ul>
        </div>
      </section>
    </div>
    <div
      class="bg-follow-background bg-cover bg-center bg-no-repeat p-4 min-h-screen ml-14"
    >
      <follow-detail-info :user_id="user_id"></follow-detail-info>
    </div>
    <div>
      <personal-center-side-bar></personal-center-side-bar>
    </div>
  </div>
</template>

<style>
@import url("@css/base.css");
@import url("@css/header.css");
</style>

<script setup>
import { ref, onMounted } from "vue";
import personalCenterSideBar from "@c/user/personalCenterSideBar.vue";
import personalInfo from "@c/user/personalInfo.vue";
import { showProductsList } from "@/api/product.js";
// Lifecycle hook
onMounted(() => {
  showProductsList(user_id).then((res) => {
    if (res.success) {
      products.value = res.data.products;
    } else {
      ElMessage({
        showClose: true,
        message: res.message,
        type: "error",
      });
    }
  });
});
const context = defineProps(["user_id"]);
const user_id = parseInt(context.user_id);
const products = ref([]);
</script>
