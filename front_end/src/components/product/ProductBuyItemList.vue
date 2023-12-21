<template>
  <div>
    <div class="ml-8 mb-2 mt-6">
      <el-select v-model="searchType" placeholder="选择搜索维度">
        <el-option label="商品名称" value="product_name"></el-option>
        <el-option label="商品出版社" value="product_press"></el-option>
        <el-option label="商家用户名" value="seller_name"></el-option>
        <el-option label="商品发货地址" value="sell_address"></el-option>
        <el-option label="商品类型" value="product_type"></el-option>
      </el-select>
      <template v-if="searchType !== 'product_type'">
        <el-input
          v-model="searchKeyword"
          placeholder="请输入关键字"
          style="width: 200px; margin-left: 10px"
        ></el-input>
      </template>
      <template v-else>
        <el-select
          v-model="searchKeyword"
          placeholder="请选择类型"
          style="width: 200px; margin-left: 10px"
        >
          <el-option
            v-for="selected in [
              '杂志',
              '教科书',
              '小说',
              '童话',
              '戏剧',
              '数学',
              '计算机',
              '漫画',
              '自传',
            ]"
            :key="selected"
            :label="selected"
            :value="selected"
          ></el-option>
        </el-select>
      </template>
      <el-switch
        class="mx-4 mb-2"
        v-model="Match"
        style="--el-switch-on-color: #13ce66; --el-switch-off-color: #ff4949"
        active-text="模糊匹配"
        :active-action-icon="View"
        :inactive-action-icon="Hide"
      />
      <div class="float-right mt-1 mx-2">
        <el-select v-model="filterType" placeholder="商品排序" class="mx-2">
          <el-option label="商品价格" value="price"></el-option>
          <el-option label="商品评论数" value="comment"></el-option>
          <el-option label="商家评分" value="score"></el-option>
        </el-select>
        <el-select v-model="filterOrder" placeholder="排序维度">
          <el-option label="降序" value="DESC"></el-option>
          <el-option label="升序" value="ASC"></el-option>
        </el-select>
      </div>
    </div>
    <div
      v-for="(product, index) in productListPerPage"
      :key="product.product_id"
    >
      <template v-if="index % 5 === 0">
        <buy-product-item :product="product" class="edge" />
        <buy-product-item
          :product="productListPerPage[index + 1]"
          v-if="index + 1 <= productListPerPage.length - 1"
        />
        <buy-product-item
          :product="productListPerPage[index + 2]"
          v-if="index + 2 <= productListPerPage.length - 1"
        />
        <buy-product-item
          :product="productListPerPage[index + 3]"
          v-if="index + 3 <= productListPerPage.length - 1"
        />
        <buy-product-item
          :product="productListPerPage[index + 4]"
          v-if="index + 4 <= productListPerPage.length - 1"
        />
      </template>
    </div>
    <el-pagination
      :current-page="currentPage"
      :page-size="pageSize"
      :total="filteredProducts.length"
      @current-change="handlePageChange"
      class="px-6 py-2"
    />
  </div>
</template>

<script>
import buyProductItem from "@c/product/buyProductItem.vue";
import { Hide, View } from "@element-plus/icons-vue";
import { ref, computed, watch } from "vue";
import { showAllProducts } from "@/api/product.js";
export default {
  components: { buyProductItem },
  name: "ProductBuyItemList",
  props: {
    products: {
      type: Array,
      required: true,
    },
  },
  setup(props) {
    const pageSize = ref(10);
    const currentPage = ref(1);
    const searchType = ref("");
    const searchKeyword = ref("");
    const filterType = ref("");
    const filterOrder = ref("");
    const Match = ref(true);
    const orderProducts = ref([]);
    const filteredProducts = computed(() => {
      const originProducts =
        filterOrder.value || filterType.value
          ? ref(orderProducts)
          : ref(props.products);
      if (searchType.value && searchKeyword.value) {
        console.log(searchType.value);
        if (Match.value) {
          originProducts.value = originProducts.value.filter((product) =>
            product[searchType.value].includes(searchKeyword.value)
          );
        } else {
          originProducts.value = originProducts.value.filter(
            (product) => product[searchType.value] == searchKeyword.value
          );
        }
      }
      return originProducts.value;
    });
    watch(
      [filterType, filterOrder],
      ([newFilterType, newFilterOrder], [oldFilterType, oldFilterOrder]) => {
        if (
          (newFilterType || newFilterOrder) &&
          (newFilterType !== oldFilterType || newFilterOrder !== oldFilterOrder)
        ) {
          showAllProducts({
            show_following: 0,
            show_order_base: newFilterType,
            show_order: newFilterOrder,
          }).then((res) => {
            if (res.success) {
              orderProducts.value = res.data.products;
            }
          });
        }
      }
    );
    const search = () => {
      currentPage.value = 1;
    };
    watch([searchType, searchKeyword, Match, filterType, filterOrder], () => {
      filteredProducts.value;
    });
    watch(searchKeyword, search);
    watch(searchType, search);
    watch(filterOrder, search);
    watch(filterType, search);
    const productListPerPage = computed(() => {
      const start = (currentPage.value - 1) * pageSize.value;
      const end = currentPage.value * pageSize.value;
      return filteredProducts.value.slice(start, end);
    });
    const handlePageChange = (newPage) => {
      currentPage.value = newPage;
    };
    return {
      searchType,
      searchKeyword,
      filteredProducts,
      Match,
      Hide,
      View,
      currentPage,
      handlePageChange,
      productListPerPage,
      search,
      pageSize,
      filterOrder,
      filterType,
    };
  },
};
</script>

<style scoped>
.edge {
  margin-left: 3%;
}
</style>
