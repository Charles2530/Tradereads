<template>
  <div>
    <div
      class="bg-notice-background bg-cover bg-center bg-no-repeat p-4 min-h-screen pl-12"
    >
      <div style="position: relative; z-index: 1">
        <personal-center-side-bar />
      </div>
      <div class="container mx-auto p-4" style="position: relative; z-index: 0">
        <div class="mb-4">
          <h1 class="text-3xl font-semibold mb-2 text-white">
            二手书交易公告栏
          </h1>
          <p class="text-gray-400 notice-detail">浏览最新的二手书信息。</p>
        </div>
        <div v-if="store.getRight == 1">
          <el-button
            @click="showCreateNoticeDialog"
            type="success"
            class="btn-create-notice"
            plain
          >
            <el-icon class="mr-3"><EditPen /></el-icon>
            发布公告
          </el-button>
        </div>
        <div>
          <el-tabs v-model="activeName" class="demo-tabs">
            <el-tab-pane label="公共通知" name="first">
              <el-scrollbar max-height="500px">
                <public-notice-list :notices="notices" />
              </el-scrollbar>
            </el-tab-pane>
            <el-tab-pane label="我的关注" name="Config">
              <el-scrollbar max-height="500px">
                <follow-notice-list :books="books" />
              </el-scrollbar>
            </el-tab-pane>
            <el-tab-pane label="我的销售" name="Seller">
              <el-scrollbar max-height="500px">
                <seller-notice-list :messages="sellerMessages" />
              </el-scrollbar>
            </el-tab-pane>
          </el-tabs>
        </div>
      </div>
    </div>
    <div>
      <el-dialog v-model="createNoticeDialog" width="50%">
        <el-form
          :model="newNotice"
          ref="createNoticeForm"
          :rules="createNoticeFormRules"
        >
          <el-text class="mx-1 launch-notice" type="info">发布公告</el-text>
          <el-form-item label="标题" prop="title">
            <el-input v-model="newNotice_title"></el-input>
          </el-form-item>
          <el-form-item label="内容" prop="content">
            <textarea
              v-model="newNotice_content"
              class="block w-full border-gray-300 rounded-md p-2 transition border focus:border-blue-500"
              rows="6"
            ></textarea>
          </el-form-item>
        </el-form>
        <div class="dialog-footer">
          <el-button @click="createNoticeDialog = false">取消</el-button>
          <el-button type="primary" @click="createNoticeFunc">发布</el-button>
        </div>
      </el-dialog>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref, computed, nextTick } from "vue";
import { userStore } from "@/store/user.js";
import { createNotice, showCurrentNotices } from "@/api/notice.js";
import { useRouter } from "vue-router";
import PublicNoticeList from "@c/notice/PublicNoticeList.vue";
import FollowNoticeList from "@c/notice/FollowNoticeList.vue";
import SellerNoticeList from "@c/notice/SellerNoticeList.vue";
const activeName = ref("first");
const AllNotice = ref([]);
const store = userStore();
const router = useRouter();
onMounted(() => {
  getNotices();
});

const notices = computed(() => {
  return AllNotice.value.filter((item) => {
    return item.notice_type === 1;
  });
});

const books = computed(() => {
  return AllNotice.value.filter((item) => {
    return item.notice_type === 2;
  });
});

const sellerMessages = computed(() => {
  return AllNotice.value.filter((item) => {
    return item.notice_type === 3;
  });
});

const getNotices = () => {
  showCurrentNotices().then((res) => {
    if (res.success) {
      console.log(res.data.notices);
      console.log(store.getRight);
      console.log(store.getRight == 1);
      AllNotice.value = res.data.notices;
    } else {
      ElMessage({
        showClose: true,
        type: "error",
        message: res.message,
      });
      router.push({ path: "/404" });
    }
  });
};

const createNoticeDialog = ref(false);
const newNotice_title = ref("");
const newNotice_content = ref("");
const newNotice = computed(() => {
  return {
    title: newNotice_title.value,
    content: newNotice_content.value,
  };
});
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
const createNoticeForm = ref(null);

const createNoticeFunc = () => {
  nextTick(() => {
    if (createNoticeForm.value) {
      createNoticeForm.value.validate(async (valid) => {
        if (valid) {
          createNotice({
            title: newNotice_title.value,
            content: newNotice_content.value,
          }).then((res) => {
            if (res.success) {
              getNotices();
              newNotice_title.value = "";
              newNotice_content.value = "";
              createNoticeDialog.value = false;
              ElMessage({
                showClose: true,
                type: "success",
                message: res.message,
              });
            } else {
              ElMessage({
                showClose: true,
                type: "error",
                message: res.message,
              });
            }
          });
        }
      });
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
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
}
.launch-notice {
  font-size: 25px;
  font-weight: bold;
  margin-bottom: 20px;
  display: block;
  text-align: center !important;
}
</style>
