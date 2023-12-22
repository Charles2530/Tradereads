<template>
  <div
    class="bg-admin-background bg-cover bg-center bg-no-repeat p-4 min-h-screen"
  >
    <div style="position: relative; z-index: 1">
      <personal-center-side-bar />
    </div>
    <div style="position: relative; z-index: 0">
      <h1 class="text-4xl font-bold text-white mb-8 flex justify-center">
        商品审核中心
      </h1>
      <div>
        <check-order-list :products="checkOrders"></check-order-list>
      </div>
    </div>
  </div>
</template>

<script setup>
import { showExamineList } from "@/api/examine.js";
import { ref, onMounted } from "vue";
import CheckOrderList from "@c/admin/CheckOrderList.vue";
import { useRouter } from "vue-router";
//methods
const checkOrders = ref([]);
const router = useRouter();

onMounted(() => {
  showExamineList().then((res) => {
    if (res.success) {
      checkOrders.value = res.data.products;
      console.log(checkOrders.value);
    } else {
      ElMessage({
        message: res.message,
        type: "error",
      });
      router.push({ path: "/404" });
    }
  });
});
</script>
