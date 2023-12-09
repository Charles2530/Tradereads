<template>
  <div
    class="bg-order-background bg-cover bg-center bg-no-repeat p-4 min-h-screen"
  >
    <div style="position: relative; z-index: 1">
      <personal-center-side-bar />
    </div>
    <div
      class="user-management mx-20 bg-white"
      style="position: relative; z-index: 0"
    >
      <user-order-management-list />
    </div>
  </div>
</template>
