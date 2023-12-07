<template>
  <div>
    <navigation-bar></navigation-bar>
    <div
      class="bg-personalCenter-background bg-cover bg-center bg-no-repeat p-4 min-h-screen"
    >
      <el-row>
        <el-col :span="5">
          <div
            class="headBar ml-100 bg-gradient-to-r from-blue-400/70 to-red-500/70 rounded-lg shadow-md p-4"
          >
            <personal-mode></personal-mode>
          </div>
        </el-col>
        <el-col :span="19"
          ><div
            class="headBar ml-100 bg-gradient-to-r from-blue-400/70 to-red-500/70 rounded-lg shadow-md p-4"
          >
            <personal-info></personal-info></div
        ></el-col>
      </el-row>
    </div>
    <div>
      <personal-center-side-bar></personal-center-side-bar>
    </div>
  </div>
</template>
