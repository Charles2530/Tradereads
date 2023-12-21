<template>
  <div class="bg-white ml-8 rounded-xl shadow-lg p-2">
    <div class="mx-2 ml-8 mt-2">
      <el-select v-model="searchType" placeholder="选择搜索维度">
        <el-option label="商品名称" value="product_name"></el-option>
        <el-option label="卖家名称" value="seller_name"></el-option>
      </el-select>
      <el-input
        v-model="searchKeyword"
        placeholder="请输入关键字"
        style="width: 200px; margin-left: 10px"
      ></el-input>
      <el-switch
        class="mx-4 mb-2"
        v-model="Match"
        style="--el-switch-on-color: #13ce66; --el-switch-off-color: #ff4949"
        active-text="模糊匹配"
        :active-action-icon="View"
        :inactive-action-icon="Hide"
      />
      <span class="text-2xl ml-250 p-2">
        已选择的商品总价:
        <span class="text-md text-red-500 font-bold"
          >￥{{ totalPrice }}</span
        ></span
      >
    </div>

    <el-divider />
    <div>
      <el-scrollbar max-height="500px">
        <div class="px-8 py-2">
          <el-table :data="filteredProducts" style="width: 97%">
            <el-table-column
              label="商品名称"
              prop="product_name"
            ></el-table-column>
            <el-table-column label="商品图片">
              <template #default="{ row }">
                <img
                  :src="row.product_image"
                  alt="Product Image"
                  class="w-36 h-36"
                />
              </template>
            </el-table-column>
            <el-table-column
              label="商品单价"
              prop="product_price"
            ></el-table-column>
            <el-table-column
              label="卖家名称"
              prop="seller_name"
            ></el-table-column>
            <el-table-column
              label="商品数量"
              prop="product_number"
            ></el-table-column>
            <el-table-column label="操作" width="160" align="center">
              <template #default="{ row }">
                <div>
                  <el-button
                    type="primary"
                    @click="goToProductDetails(row.product_id)"
                    plain
                  >
                    <el-icon class="mr-1"><Link /></el-icon>
                    详细信息</el-button
                  >
                </div>
                <div class="mt-2">
                  <el-popconfirm
                    title="确定将所选商品移出购物车吗?"
                    @confirm="deleteProductFromCart(row.product_id)"
                  >
                    <template #reference>
                      <el-button type="danger" plain>
                        <el-icon class="mr-1"><Delete /></el-icon>
                        删除商品
                      </el-button>
                    </template>
                  </el-popconfirm>
                </div>
              </template>
            </el-table-column>
            <el-table-column label="加入订单" width="120" align="center">
              <template #default="{ row }">
                <el-switch
                  v-model="row.selected"
                  class="mt-2"
                  style="margin-left: 12px"
                  inline-prompt
                  :active-icon="Check"
                  :inactive-icon="Close"
                />
              </template>
            </el-table-column>
          </el-table>
        </div>
      </el-scrollbar>
    </div>
  </div>
</template>

<script>
import { computed, ref } from "vue";
import { useRouter } from "vue-router";
import { Close, Check, Hide, View } from "@element-plus/icons-vue";
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
          return total + item.product_price * item.product_number;
        }
        return total;
      }, 0);
    });

    const stockClass = (productStore) => ({
      "text-red-500": productStore === 0,
      "text-green-500": productStore > 0,
    });

    const stockStatus = (productStore) => (productStore > 0 ? "有货" : "售完");

    const goToProductDetails = (product_id) => {
      router.push({
        name: "ProductDetail",
        params: {
          product_id: product_id,
        },
      });
    };

    const deleteProductFromCart = (product_id) => {
      console.log(product_id);
    };
    //search
    const searchType = ref("");
    const searchKeyword = ref("");
    const Match = ref(true);
    const filteredProducts = computed(() => {
      const originProducts = ref(props.products);
      if (searchType.value && searchKeyword.value) {
        if (Match.value) {
          originProducts.value = props.products.filter((product) =>
            product[searchType.value].includes(searchKeyword.value)
          );
        } else {
          originProducts.value = props.products.filter(
            (product) => product[searchType.value] == searchKeyword.value
          );
        }
      }
      return originProducts.value;
    });
    return {
      stockClass,
      stockStatus,
      goToProductDetails,
      totalPrice,
      Close,
      Check,
      Hide,
      View,
      filteredProducts,
      searchKeyword,
      searchType,
      Match,
      deleteProductFromCart,
    };
  },
};
</script>
