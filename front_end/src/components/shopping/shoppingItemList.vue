<template>
  <div>
    <el-table :data="products" style="width: 100%">
      <el-table-column label="商品名称" prop="product_name"></el-table-column>
      <el-table-column label="商品图片">
        <template #default="{ row }">
          <img :src="row.product_image" alt="Product Image" class="w-36 h-36" />
        </template>
      </el-table-column>
      <el-table-column label="商品单价" prop="product_price"></el-table-column>
      <el-table-column label="卖家名称" prop="seller_name"></el-table-column>
      <el-table-column label="商品数量" prop="product_number"></el-table-column>
      <el-table-column label="操作" width="120">
        <template #default="{ row }">
          <el-button type="primary" @click="goToProductDetails(row.product_id)"
            >详细信息</el-button
          >
        </template>
      </el-table-column>
      <el-table-column label="选择" width="120">
        <template #default="{ row }">
          <el-switch
            v-model="row.selected"
            class="mt-2"
            style="margin-left: 24px"
            inline-prompt
            :active-icon="Check"
            :inactive-icon="Close"
          />
        </template>
      </el-table-column>
    </el-table>
    <div class="text-right mt-4">
      <span class="text-lg">已选择的商品总价: ￥{{ totalPrice }}</span>
    </div>
  </div>
</template>

<script>
import { computed } from "vue";
import { useRouter } from "vue-router";
import { Close, Check } from "@element-plus/icons-vue";
export default {
  name: "ShoppingItemList",
  props: {
    products: {
      type: Object,
      required: true,
    },
  },
  setup(props) {
    const router = useRouter();
    const totalPrice = computed(() => {
      return props.products.reduce((total, item) => {
        if (item.selected) {
          return total + item.product_price;
        }
        return total;
      }, 0);
    });

    const stockClass = (productStore) => ({
      "text-red-500": productStore === 0,
      "text-green-500": productStore > 0,
    });

    const stockStatus = (productStore) => (productStore > 0 ? "有货" : "售完");

    const goToProductDetails = (productId) => {
      console.log(productId);
      router.push({
        name: "ProductDetail",
        params: {
          id: productId,
        },
      });
    };

    return {
      stockClass,
      stockStatus,
      goToProductDetails,
      totalPrice,
      Close,
      Check,
    };
  },
};
</script>

<style scoped>
.el-table th,
.el-table td {
  text-align: center;
}
</style>
