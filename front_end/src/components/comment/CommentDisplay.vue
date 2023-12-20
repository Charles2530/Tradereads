<template>
  <div class="comment-display">
    <div class="user-info">
      <div class="user-id text-xl">{{ comment.user_name }}</div>
      <div class="comment-date">{{ formatDate(comment.date) }}</div>
    </div>
    <el-rate v-model="comment.score" :max="5" disabled></el-rate>
    <p class="comment-content">{{ comment.content }}</p>
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
  methods: {
    formatDate(dateString) {
      const options = { year: "numeric", month: "long", day: "numeric" };
      return new Date(dateString).toLocaleDateString(undefined, options);
    },
  },
};
</script>

<style scoped>
.comment-display {
  border: 1px solid #ccc;
  padding: 10px;
  margin: 10px;
}

.user-info {
  display: flex;
  justify-content: space-between;
  margin-bottom: 10px;
}

.user-id {
  font-weight: bold;
}

.comment-date {
  color: #888;
}

.comment-content {
  font-size: 16px;
}
</style>
