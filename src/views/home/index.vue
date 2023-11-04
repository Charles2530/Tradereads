<template>
  <div class="homepage">
    <h1 class="homeView w-24 text-blue-500">{{ project_title }}</h1>
    <p>
      <router-link
        to="/login"
        class="login_button w-48 font-bold text-2xl text-red-600"
        >登录</router-link
      >
    </p>
  </div>
</template>

<script>
export default {
  data() {
    return {
      project_title: "DataBase Project",
    };
  },
};
</script>
