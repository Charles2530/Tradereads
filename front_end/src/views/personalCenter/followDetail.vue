<template>
  <div>
    <navigation-bar></navigation-bar>
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

<script setup>
import personalCenterSideBar from "@c/user/personalCenterSideBar.vue";
import NavigationBar from "@c/home/NavigationBar.vue";
const context = defineProps(["user_id"]);
const user_id = parseInt(context.user_id);
</script>
