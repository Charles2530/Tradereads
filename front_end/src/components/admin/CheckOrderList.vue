<template>
  <div class="m-100 bg-white" style="position: relative; z-index: 0">
    <h1 class="text-4xl font-bold mb-8 flex justify-center">商品审核中心</h1>
    <el-divider></el-divider>
    <div>
      <div>
        <el-switch
          class="mx-4 my-2"
          v-model="showApproved"
          style="--el-switch-on-color: #13ce66; --el-switch-off-color: #ff4949"
          active-text="显示已审核"
          :active-action-icon="View"
          :inactive-action-icon="Hide"
        />
      </div>
    </div>
    <div v-if="showApproved && approvedProducts.length > 0">
      <el-scrollbar max-height="500px">
        <el-table :data="approvedProducts" style="width: 100%">
          <el-table-column
            label="商品名称"
            prop="product_name"
          ></el-table-column>
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
                  >通过该审核</el-button
                >
              </div>
              <div>
                <el-button
                  v-if="!scope.row.check_state"
                  @click="disapproveProduct(scope.row)"
                  type="danger"
                  plain
                  >拒绝该审核</el-button
                >
              </div>
            </template>
          </el-table-column>
        </el-table>
      </el-scrollbar>
    </div>
    <div v-if="!showApproved && pendingProducts.length > 0">
      <el-scrollbar max-height="500px">
        <el-table :data="pendingProducts" style="width: 100%">
          <el-table-column
            label="商品名称"
            prop="product_name"
          ></el-table-column>
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
                  >通过该审核</el-button
                >
              </div>
              <div>
                <el-button
                  v-if="!scope.row.check_state"
                  @click="disapproveProduct(scope.row)"
                  type="danger"
                  plain
                  >拒绝该审核</el-button
                >
              </div>
            </template>
          </el-table-column>
        </el-table>
      </el-scrollbar>
    </div>
    <div v-if="products.length === 0">
      <h1 class="text-2xl text-center">没有待审核的商品</h1>
    </div>
  </div>
</template>

<script>
import { ref, computed } from "vue";
import { ExamineProduct } from "@/api/examine.js";
import { Hide, View } from "@element-plus/icons-vue";
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

    const toggleShowApproved = () => {
      showApproved.value = !showApproved.value;
    };

    const approvedProducts = computed(() => {
      return props.products.filter((product) => product.check_state);
    });

    const pendingProducts = computed(() => {
      return props.products.filter((product) => !product.check_state);
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

    return {
      showApproved,
      toggleShowApproved,
      approvedProducts,
      pendingProducts,
      approveProduct,
      disapproveProduct,
      Hide,
      View,
    };
  },
};
</script>
