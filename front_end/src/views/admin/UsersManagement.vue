<template>
  <div
    class="bg-admin-background bg-cover bg-center bg-no-repeat p-4 min-h-screen"
  >
    <div style="position: relative; z-index: 1">
      <personal-center-side-bar />
    </div>
    <div style="position: relative; z-index: 0">
      <div class="user-management mx-20 bg-white rounded-xl">
        <user-management-list :userList="users" />
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from "vue";
import { showAllUserList } from "@/api/user";
import { ElMessage } from "element-plus";
const users = ref([]);

onMounted(() => {
  showAllUserList().then((res) => {
    if (res.success) {
      users.value = res.data.users;
    } else {
      ElMessage({
        showClose: true,
        message: res.message,
        type: "error",
      });
    }
  });
});
</script>

<style scoped>
.user-management {
  padding: 20px;
}
</style>
