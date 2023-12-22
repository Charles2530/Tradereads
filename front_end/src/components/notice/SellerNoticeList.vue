<template>
  <div>
    <div v-if="messages.length === 0">
      <h1 class="text-2xl text-center text-white font-bold">
        当前没有销售通知
      </h1>
    </div>
    <div>
      <el-card class="mb-4" v-for="message in messages" :key="message.id">
        <div>
          <div v-if="!message.notice_readed">
            <el-tag type="warning" round>
              <el-icon><ReadingLamp /></el-icon>
              未读</el-tag
            >
          </div>
        </div>
        <div class="flex justify-between items-center">
          <h2 class="text-xl font-semibold">{{ message.notice_title }}</h2>
          <span class="text-gray-500">{{ message.notice_create_time }}</span>
        </div>
        <p class="text-gray-700 mt-2">{{ message.notice_content }}</p>
        <div class="mt-4 flex justify-end">
          <div>
            <el-button
              type="success"
              class="text-white font-semibold hover:underline"
              @click="viewDetails(message.notice_user_id)"
              plain
            >
              <el-icon class="ml-1 mr-4"><Position /></el-icon>
              点击查看&nbsp;
              <strong> {{ message.notice_user_name }} </strong>
              &nbsp;的个人中心</el-button
            >
          </div>
        </div>
      </el-card>
    </div>
  </div>
</template>

<script>
import { useRouter } from "vue-router";
export default {
  name: "SellerNoticeList",
  props: {
    messages: {
      type: Array,
      required: true,
    },
  },
  setup() {
    const router = useRouter();
    const viewDetails = (user_id) => {
      router.push({
        name: "FollowDetail",
        params: {
          user_id,
        },
      });
    };
    return {
      viewDetails,
    };
  },
};
</script>

<style scoped></style>
