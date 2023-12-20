<template>
  <div>
    <el-rate v-model="comment.score" :max="5" disabled></el-rate>
    <p class="text-lg">{{ comment.content }}</p>
  </div>
</template>
<script>
export default {
  name: "CommentDisplay",
  props: {
    comment: {
      type: Object,
      required: true,
    },
  },
  setup() {},
};
</script>
