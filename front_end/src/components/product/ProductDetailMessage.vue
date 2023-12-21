<template>
  <div class="bg-white ml-24">
    <div class="p-1 border rounded-lg shadow-lg product-item">
      <product-detail :product="product" :product_id="product_id" />
    </div>
    <div class="p-1 border rounded-lg shadow-lg my-4">
      <el-row>
        <el-col :span="24">
          <p class="text-2xl font-bold mb-4 flex justify-center">用户评价</p>
          <el-button
            class="ml-3"
            type="success"
            @click="CommentDialog = true"
            plain
          >
            <el-icon class="ml-1 mr-2"><Comment /></el-icon>
            发布评论</el-button
          >
          <div v-if="comments.length === 0">暂无评价</div>
          <div v-else>
            <div v-for="(comment, index) in comments" :key="index" class="mb-4">
              <div v-if="index % 2 == 0">
                <el-row>
                  <el-col :span="12">
                    <comment-display :comment="comment" />
                  </el-col>
                  <el-col :span="12">
                    <comment-display
                      :comment="comments[index + 1]"
                      v-if="index + 1 < comments.length"
                    />
                  </el-col>
                </el-row>
              </div>
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
            <el-rate v-model="newComment.score" :max="5"></el-rate>
            <el-input
              v-model="newComment.content"
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
import { showComment, addComment } from "@/api/comment.js";
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
      showComment(props.product_id).then((res) => {
        if (res.success) {
          console.log(res.data.comments);
          comments.value = res.data.comments;
        }
      });
    });
    const product = ref([]);
    const comments = ref([]);
    const newComment = ref({
      score: 0,
      content: "",
    });
    const submitComment = () => {
      const newCommentJson = {
        content: newComment.value.content,
        score: newComment.value.score,
      };
      comments.value.push(newCommentJson);
      addComment(props.product_id, newCommentJson).then((res) => {
        console.log(res);
        if (res.success) {
          ElMessage({
            message: "评论成功",
            type: "success",
          });
          location.reload();
        } else {
          ElMessage({
            message: "评论失败",
            type: "error",
          });
        }
      });

      newComment.value.score = 0;
      newComment.value.content = "";
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
