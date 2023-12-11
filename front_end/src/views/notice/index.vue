<template>
  <div
    class="bg-notice-background bg-cover bg-center bg-no-repeat p-4 min-h-screen pl-12"
  >
    <div style="position: relative; z-index: 1">
      <personal-center-side-bar />
    </div>
    <div class="container mx-auto p-4" style="position: relative; z-index: 0">
      <div class="mb-4">
        <h1 class="text-3xl font-semibold mb-2 text-white">二手书交易公告栏</h1>
        <p class="text-gray-400 notice-detail">浏览最新的二手书信息。</p>
      </div>
      <!-- <div v-if="store.getRight === 1"> -->
      <div>
        <el-button
          @click="showCreateNoticeDialog"
          plain
          class="btn-create-notice"
        >
          发布公告
        </el-button>
      </div>
      <div>
        <el-tabs v-model="activeName" class="demo-tabs">
          <el-tab-pane label="公共通知" name="first"
            ><public-notice-list :notices="notices"
          /></el-tab-pane>
          <el-tab-pane label="我的关注" name="Config">
            <follow-notice-list :books="books" />
          </el-tab-pane>
        </el-tabs>
      </div>
    </div>
  </div>
  <div>
    <el-dialog v-model="createNoticeDialog" title="发布公告" width="50%">
      <el-form
        :model="newNotice"
        ref="createNoticeForm"
        :rules="createNoticeFormRules"
      >
        <el-form-item label="标题" prop="title">
          <el-input v-model="newNotice.title"></el-input>
        </el-form-item>
        <el-form-item label="内容" prop="content">
          <el-input type="textarea" v-model="newNotice.content"></el-input>
        </el-form-item>
      </el-form>

      <div class="dialog-footer">
        <el-button @click="createNoticeDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="createNoticeFunc">发布</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { onMounted, ref, computed } from "vue";
import { userStore } from "@/store/user.js";
import { createNotice, showCurrentNotices } from "@/api/notice.js";
import PublicNoticeList from "@c/notice/PublicNoticeList.vue";
import FollowNoticeList from "@c/notice/FollowNoticeList.vue";
const activeName = ref("first");
const AllNotice = ref([]);
const store = userStore();
onMounted(() => {
  getNotices();
});

const notices = computed(() => {
  return AllNotice.value.filter((item) => {
    return item.notice_type === 0;
  });
});

const books = computed(() => {
  return AllNotice.value.filter((item) => {
    return item.notice_type === 1;
  });
});
const getNotices = () => {
  showCurrentNotices().then((res) => {
    if (res.success) {
      console.log(res.data.notice);
      AllNotice.value = res.data.notice;
    } else {
      ElMessage({
        showClose: true,
        type: "error",
        message: res.message,
      });
    }
  });
};

const createNoticeDialog = ref(false);
const newNotice = {
  title: "",
  content: "",
};
const createNoticeFormRules = {
  title: [
    { required: true, message: "请输入标题", trigger: "blur" },
    { min: 1, max: 20, message: "长度在 1 到 20 个字符", trigger: "blur" },
  ],
  content: [
    { required: true, message: "请输入内容", trigger: "blur" },
    { min: 1, max: 100, message: "长度在 1 到 100 个字符", trigger: "blur" },
  ],
};

const showCreateNoticeDialog = () => {
  createNoticeDialog.value = true;
};

const createNoticeFunc = () => {
  const form = ref("createNoticeForm");
  form.value.validate(async (valid) => {
    if (valid) {
      try {
        createNotice(newNotice).then((res) => {
          if (res.success) {
            console.log(res.data.notice);
            getNotices();
            newNotice.title = "";
            newNotice.content = "";
            createNoticeDialog.value = false;
          } else {
            ElMessage({
              showClose: true,
              type: "error",
              message: res.message,
            });
          }
        });
      } catch (error) {
        console.error(error);
      }
    }
  });
};
</script>

<style>
.notice-detail:hover {
  color: #fff !important;
  text-decoration: underline;
}

.el-tabs__item {
  color: #fff !important;
}

.el-tabs__item.is-active {
  color: #409eff !important;
}

.btn-create-notice {
  background-color: #409eff;
  color: #fff;
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
}
</style>
