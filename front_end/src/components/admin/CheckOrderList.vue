<template>
  <div class="mx-100 mt-20 bg-white rounded-xl">
    <div>
      <div class="items-center">
        <el-switch
          class="mx-4 my-2"
          v-model="showApproved"
          style="--el-switch-on-color: #13ce66; --el-switch-off-color: #ff4949"
          active-text="显示已审核"
          :active-action-icon="Check"
          :inactive-action-icon="Close"
        />
        <div class="float-right">
          <el-select v-model="searchType" placeholder="选择搜索维度">
            <el-option label="商品名称" value="product_name"></el-option>
            <el-option label="商品出版社" value="product_press"></el-option>
            <el-option label="商家用户名" value="seller_name"></el-option>
            <el-option label="商品发货地址" value="sell_address"></el-option>
          </el-select>
          <el-input
            v-model="searchKeyword"
            placeholder="请输入关键字"
            style="width: 200px; margin-left: 10px"
          ></el-input>
          <el-switch
            class="mx-4 mb-2"
            v-model="Match"
            style="
              --el-switch-on-color: #13ce66;
              --el-switch-off-color: #ff4949;
            "
            active-text="模糊匹配"
            :active-action-icon="View"
            :inactive-action-icon="Hide"
          />
        </div>
      </div>
    </div>
    <div v-if="showApproved && approvedProducts.length > 0">
      <el-table :data="approvedProducts" style="width: 100%">
        <el-table-column label="商品名称" prop="product_name"></el-table-column>
        <el-table-column label="价格" prop="price"></el-table-column>
        <el-table-column
          label="商品出版社"
          prop="product_press"
        ></el-table-column>
        <el-table-column
          label="商家用户名"
          prop="seller_name"
        ></el-table-column>
        <el-table-column
          label="商品发货地址"
          prop="sell_address"
          min-width="150px"
        ></el-table-column>
        <el-table-column label="状态" prop="check_state">
          <template #default="scope">
            <span
              :class="{
                'text-green-500': scope.row.check_state,
                'text-red-500': !scope.row.check_state,
              }"
            >
              {{ scope.row.check_state ? "已审核" : "待审核" }}
            </span>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination
        v-if="showApproved"
        v-model="approvedPage"
        :page-size="approvedPageSize"
        :total="approvedSize"
        :current-page="approvedPage"
        @current-change="handleApprovedPageChange"
      ></el-pagination>
    </div>
    <div v-if="!showApproved && pendingProducts.length > 0">
      <el-table :data="pendingProducts" style="width: 100%">
        <el-table-column label="商品名称" prop="product_name"></el-table-column>
        <el-table-column label="价格" prop="price"></el-table-column>
        <el-table-column
          label="商品出版社"
          prop="product_press"
        ></el-table-column>
        <el-table-column
          label="商家用户名"
          prop="seller_name"
        ></el-table-column>
        <el-table-column
          label="商品发货地址"
          prop="sell_address"
          min-width="150px"
        ></el-table-column>
        <el-table-column label="状态" prop="check_state">
          <template #default="scope">
            <span
              :class="{
                'text-green-500': scope.row.check_state,
                'text-red-500': !scope.row.check_state,
              }"
            >
              {{ scope.row.check_state ? "已审核" : "待审核" }}
            </span>
          </template>
        </el-table-column>
        <el-table-column label="操作">
          <template #default="scope">
            <div>
              <el-button
                v-if="!scope.row.check_state"
                @click="approveProduct(scope.row)"
                type="primary"
                plain
                size="small"
              >
                <el-icon class="mr-3"><Check /></el-icon>
                通过该审核</el-button
              >
            </div>
            <div>
              <el-button
                v-if="!scope.row.check_state"
                @click="disapproveProduct(scope.row)"
                type="danger"
                plain
                size="small"
              >
                <el-icon class="mr-3"><Close /></el-icon>
                拒绝该审核</el-button
              >
            </div>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination
        v-if="!showApproved"
        v-model="pendingPage"
        :page-size="pendingPageSize"
        :total="pendingSize"
        :current-page="pendingPage"
        @current-change="handlePendingPageChange"
        class="px-6"
      ></el-pagination>
    </div>

    <div v-if="products.length === 0">
      <h1 class="text-2xl text-center">没有待审核的商品</h1>
    </div>
  </div>
</template>

<script>
import { ref, computed, watch } from "vue";
import { ExamineProduct } from "@/api/examine.js";
import { Hide, View, Check, Close } from "@element-plus/icons-vue";
export default {
  name: "CheckOrderList",
  props: {
    products: {
      type: Array,
      required: true,
    },
  },
  setup(props) {
    const showApproved = ref(false);
    const approvedPageSize = ref(10);
    const pendingPageSize = ref(5);
    const approvedPage = ref(1);
    const pendingPage = ref(1);
    const approvedSize = ref(0);
    const pendingSize = ref(0);
    const searchType = ref("");
    const searchKeyword = ref("");
    const filteredProducts = computed(() => {
      if (searchType.value && searchKeyword.value) {
        if (Match.value) {
          return props.products.filter((product) =>
            product[searchType.value].includes(searchKeyword.value)
          );
        } else {
          return props.products.filter(
            (product) => product[searchType.value] == searchKeyword.value
          );
        }
      } else {
        return props.products;
      }
    });
    const Match = ref(true);
    const search = () => {
      approvedPage.value = 1;
      pendingPage.value = 1;
    };
    watch(searchType, search);
    watch(searchKeyword, search);

    const toggleShowApproved = () => {
      showApproved.value = !showApproved.value;
    };

    const approvedProducts = computed(() => {
      const startIdx = (approvedPage.value - 1) * approvedPageSize.value;
      const endIdx = startIdx + approvedPageSize.value;
      const approvedProducts = filteredProducts.value.filter(
        (product) => product.check_state
      );
      approvedSize.value = approvedProducts.length;
      return approvedProducts.slice(startIdx, endIdx);
    });

    const pendingProducts = computed(() => {
      const startIdx = (pendingPage.value - 1) * pendingPageSize.value;
      const endIdx = startIdx + pendingPageSize.value;
      const pendingProducts = filteredProducts.value.filter(
        (product) => !product.check_state
      );
      pendingSize.value = pendingProducts.length;
      return pendingProducts.slice(startIdx, endIdx);
    });

    const approveProduct = (product) => {
      product.check_state = true;
      const check_result = 1;
      ExamineProduct(product.product_id, { check_result }).then((res) => {
        if (res.success) {
          console.log(res.data);
        } else {
          ElMessage({
            message: res.message,
            type: "error",
          });
        }
      });
    };

    const disapproveProduct = (product) => {
      product.check_state = true;
      const check_result = 0;
      ExamineProduct(product.product_id, { check_result }).then((res) => {
        if (res.success) {
          console.log(res.data);
        } else {
          ElMessage({
            message: res.message,
            type: "error",
          });
        }
      });
    };

    const handleApprovedPageChange = (page) => {
      approvedPage.value = page;
    };

    const handlePendingPageChange = (page) => {
      pendingPage.value = page;
    };

    watch(showApproved, () => {
      approvedPage.value = 1;
      pendingPage.value = 1;
    });

    return {
      showApproved,
      toggleShowApproved,
      approvedProducts,
      pendingProducts,
      approveProduct,
      disapproveProduct,
      Hide,
      View,
      Check,
      Close,
      approvedPage,
      pendingPage,
      handleApprovedPageChange,
      handlePendingPageChange,
      approvedPageSize,
      pendingPageSize,
      approvedSize,
      pendingSize,
      searchType,
      searchKeyword,
      search,
      filteredProducts,
      Match,
    };
  },
};
</script>

<style>
.el-table-column,
.el-pagination {
  margin-top: 10px !important;
  margin-right: 30px !important;
  padding-bottom: 10px !important;
}
.el-table {
  border-radius: 10px !important; /* 调整圆角大小 */
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1) !important; /* 添加阴影 */
}

.el-pagination {
  border-radius: 10px !important;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1) !important;
}

.el-button {
  border-radius: 5px !important;
  padding: 5px 15px !important;
}
</style>
