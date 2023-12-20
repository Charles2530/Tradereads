<template>
  <div>
    <navigation-bar></navigation-bar>
    <div
      class="bg-productBuyCenter-background bg-cover bg-center bg-no-repeat p-4 min-h-screen pl-12"
    >
      <div style="position: relative; z-index: 1">
        <personal-center-side-bar />
      </div>
      <div class="container mx-auto p-4" style="position: relative; z-index: 0">
        <div class="mb-4">
          <h1 class="text-3xl font-semibold mb-2 text-white">二手书商品中心</h1>
          <p class="text-gray-200 notice-detail">快来选购你想要的二手书吧!</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup></script>

<style>
.notice-detail:hover {
  color: #fff !important;
  text-decoration: underline;
}
</style>
