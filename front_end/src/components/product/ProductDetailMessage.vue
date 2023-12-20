<template>
  <div class="bg-white ml-24">
    <div class="p-1 border rounded-lg shadow-lg product-item">
      <product-detail :product="product" :product_id="product_id" />
    </div>

    <div class="p-1 border rounded-lg shadow-lg my-4">
      <el-row>
        <el-col :span="24">
          <p class="text-2xl font-bold mb-4 flex justify-center">用户评价</p>
          <el-button type="success" @click="CommentDialog = true" plain>
            <el-icon class="ml-1 mr-2"><Comment /></el-icon>
            发布评论</el-button
          >
          <div v-if="comments.length === 0">暂无评价</div>
          <div v-else>
            <div v-for="(comment, index) in comments" :key="index" class="mb-4">
              <el-rate v-model="comment.rating" :max="5" disabled></el-rate>
              <p class="text-lg">{{ comment.text }}</p>
            </div>
          </div>
        </el-col>
      </el-row>
    </div>
    <el-dialog v-model="CommentDialog">
      <div class="p-1 border rounded-lg shadow-lg my-4">
        <el-row>
          <el-col :span="24">
            <p class="text-2xl font-bold mb-4">发表评论</p>
            <el-rate v-model="newComment.rating" :max="5"></el-rate>
            <el-input
              v-model="newComment.text"
              type="textarea"
              :rows="4"
              placeholder="请输入您的评论"
              class="mb-4"
            ></el-input>
            <el-button type="primary" @click="submitComment"
              >提交评论</el-button
            >
          </el-col>
        </el-row>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { onMounted, ref } from "vue";
import { getProduct } from "@/api/product.js";
export default {
  name: "ProductDetailMessage",
  props: {
    product_id: {
      type: Number,
      required: true,
    },
  },
  setup(props) {
    onMounted(() => {
      getProduct(props.product_id).then((res) => {
        if (res.success) {
          product.value = res.data;
        }
      });
    });
    const product = ref([]);
    const comments = ref([]);
    const newComment = ref({
      rating: 0,
      text: "",
    });
    const submitComment = () => {
      const newComment = {
        rating: this.newComment.rating,
        text: this.newComment.text,
      };
      this.comments.push(newComment);

      this.newComment.rating = 0;
      this.newComment.text = "";
      CommentDialog.value = false;
    };
    const CommentDialog = ref(false);

    return {
      comments,
      newComment,
      submitComment,
      product,
      CommentDialog,
    };
  },
};
</script>
<style scoped></style>
