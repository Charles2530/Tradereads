<template>
  <div
    class="bg-order-background bg-cover bg-center bg-no-repeat p-4 min-h-screen"
  >
    <div style="position: relative; z-index: 1">
      <personal-center-side-bar />
    </div>
    <div style="position: relative; z-index: 0">
      <h1 class="text-4xl font-bold text-white mb-8 flex justify-center">
        订单列表
      </h1>
      <div class="user-management mx-20 bg-white rounded-xl">
        <user-order-management-list />
      </div>
    </div>
  </div>
</template>
