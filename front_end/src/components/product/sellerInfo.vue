<template>
  <div class="seller-info">
    <div class="rank-display">
      <p class="rank-text" :class="rankClass">
        <el-icon class="mr-2"><Position /></el-icon>
        {{ rank }}
      </p>
    </div>
    <div class="content">
      <div class="avatar-section">
        <img :src="merchant.user_avatar" alt="Avatar" class="avatar-img" />
      </div>
      <div class="info-section">
        <p class="user-name text-2xl">{{ merchant.user_name }}</p>
        <p class="sales text-xl">
          <strong class="mr-3">总销售额:</strong>
          <span class="text-yellow-600 font-bold">￥{{ merchant.value }}</span>
        </p>
      </div>
      <div class="action-section">
        <el-button
          :type="rankType"
          size="large"
          class="details-button"
          @click="goDetails"
          plain
        >
          <el-icon class="ml-1 mr-4"><Share /></el-icon>
          查看该商家的主页
        </el-button>
      </div>
    </div>
  </div>
</template>

<script>
import { useRouter } from "vue-router";
import { computed } from "vue";
export default {
  name: "sellerInfo",
  props: {
    merchant: {
      type: Object,
      required: true,
    },
    rank: {
      type: Number,
      required: true,
    },
  },
  computed: {
    rankClass() {
      switch (this.rank) {
        case 1:
          return "rank-first";
        case 2:
          return "rank-second";
        case 3:
          return "rank-third";
        default:
          return "rank-other";
      }
    },
  },

  setup(props) {
    const router = useRouter();
    const goDetails = () => {
      router.push({
        name: "FollowDetail",
        params: {
          user_id: props.merchant.user_id,
        },
      });
    };
    const rankType = computed(() => {
      switch (props.rank) {
        case 1:
          return "danger";
        case 2:
          return "warning";
        case 3:
          return "success";
        default:
          return "info";
      }
    });
    return {
      goDetails,
      rankType,
    };
  },
};
</script>

<style scoped>
.seller-info {
  padding: 10px;
  border-bottom: 1px solid #eee;
}

.rank-display {
  flex-basis: 10%;
  text-align: center;
}

.rank-text {
  font-size: 32px;
  font-weight: bold;
}

.content {
  display: flex;
  flex-grow: 1;
  align-items: center;
}

.avatar-section {
  flex-basis: 15%;
  padding: 0 10px;
}

.avatar-img {
  width: 100%;
  border-radius: 50%;
}

.info-section {
  flex-basis: 50%;
}

.user-name,
.sales {
  margin: 10px 0;
  margin-left: 80px;
  color: #555;
}

.action-section {
  flex-basis: 25%;
  text-align: right;
}

.details-button {
  font-size: 14px;
}

.rank-first {
  color: #ef4806;
}

.rank-second {
  color: #f5a623;
}

.rank-third {
  color: #f8e71c;
}

.rank-other {
  color: #555;
}
</style>
