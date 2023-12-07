<template>
  <div>
    <section class="shortcut">
      <div class="website-name w fixed left-28">
        <ul>
          <li>Welcome to Tradereads!&nbsp;</li>
        </ul>
      </div>
      <div class="flex-container">
        <el-badge is-dot class="item" v-if="hasNotice">
          <el-button @click="goNotice" class="button"
            ><el-icon><Bell /></el-icon
          ></el-button>
        </el-badge>
        <el-badge class="item_other" v-else>
          <el-button @click="goNotice" class="button"
            ><el-icon><Bell /></el-icon
          ></el-button>
        </el-badge>
      </div>
    </section>
  </div>
</template>

<script>
import { useRouter } from "vue-router";
import { ref } from "vue";
export default {
  setup() {
    const router = useRouter();
    const hasNotice = ref(false);
    const goNotice = () => {
      hasNotice.value = false;
      router.push("/notice");
    };
    return {
      goNotice,
      hasNotice,
    };
  },
};
</script>
<style>
@import url("@css/base.css");
@import url("@css/header.css");
.website-name {
  color: #ffd04b; /* 文本颜色 */
  transition: color 0.3s ease-in-out; /* 添加过渡效果 */
  border-radius: 5px;
}

.website-name:hover {
  color: #6cb2eb; /* 悬停时改变文本颜色 */
}
.item {
  margin-top: 4px;
  margin-right: 40px;
}

.item_other {
  margin-right: 40px;
}
.el-dropdown {
  margin-top: 1.1rem;
}

.flex-container {
  display: flex;
  align-items: center; /* 垂直居中对齐 */
  justify-content: flex-end; /* 在容器中右对齐 */
}

.button {
  background-color: rgb(192, 178, 197) !important;
}
</style>
