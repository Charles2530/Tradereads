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
    </div>
    <div v-for="(product, index) in filteredProducts" :key="product.product_id">
      <template v-if="index % 5 === 0">
        <buy-product-item :product="product" class="edge" />
        <buy-product-item
          :product="filteredProducts[index + 1]"
          v-if="index + 1 <= filteredProducts.length - 1"
        />
        <buy-product-item
          :product="filteredProducts[index + 2]"
          v-if="index + 2 <= filteredProducts.length - 1"
        />
        <buy-product-item
          :product="filteredProducts[index + 3]"
          v-if="index + 3 <= filteredProducts.length - 1"
        />
        <buy-product-item
          :product="filteredProducts[index + 4]"
          v-if="index + 4 <= filteredProducts.length - 1"
        />
      </template>
    </div>
  </div>
</template>

<script>
import buyProductItem from "@c/product/buyProductItem.vue";
import { Hide, View } from "@element-plus/icons-vue";
import { ref, computed } from "vue";
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
    return {
      searchType,
      searchKeyword,
      filteredProducts,
      Match,
      Hide,
      View,
    };
  },
};
</script>

<style scoped>
.edge {
  margin-left: 3%;
}
</style>
