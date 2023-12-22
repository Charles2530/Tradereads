<template>
  <div>
    <div
      class="bg-productBuyCenter-background bg-cover bg-center bg-no-repeat p-4 min-h-screen pl-12"
    >
      <div style="position: relative; z-index: 1">
        <personal-center-side-bar />
      </div>
      <div class="container mx-auto p-4" style="position: relative; z-index: 0">
        <div class="mb-4 ml-20">
          <h1 class="text-3xl font-semibold mb-2 text-white">二手书商品中心</h1>
          <p class="text-gray-200 notice-detail">快来选购你想要的二手书吧!</p>
          <el-button
            class="mt-2"
            type="primary"
            plain
            @click="showAddProductDialog = true"
          >
            <el-icon class="ml-1 mr-4"><Connection /></el-icon>
            发布商品</el-button
          >
          <el-button
            class="mt-2"
            type="success"
            plain
            @click="showTypeDialog = true"
          >
            <el-icon class="ml-1 mr-4"><Management /></el-icon>
            类别视图</el-button
          >
        </div>
        <div class="user-management mx-20 bg-white rounded-xl">
          <product-buy-item-list :products="products" />
        </div>
      </div>
    </div>
    <el-dialog v-model="showAddProductDialog" width="30%">
      <el-form :model="newProduct" ref="newProductForm" label-width="120px">
        <el-form-item label="商品价格" prop="price">
          <el-input-number
            v-model="newProduct.price"
            :precision="2"
          ></el-input-number>
        </el-form-item>
        <el-form-item label="发货地址" prop="sell_address">
          <el-input v-model="newProduct.sell_address"></el-input>
        </el-form-item>
        <el-form-item label="商品库存" prop="store">
          <el-input-number v-model="newProduct.store"></el-input-number>
        </el-form-item>
        <el-form-item label="商品名称" prop="product_name">
          <el-input v-model="newProduct.product_name"></el-input>
        </el-form-item>
        <el-form-item label="商品图片" prop="product_image">
          <product-image-upload @image-uploaded="handleImageUploaded" />
        </el-form-item>
        <el-form-item label="商品出版社" prop="product_press">
          <el-input v-model="newProduct.product_press"></el-input>
        </el-form-item>
        <el-form-item label="商品类型" prop="product_type">
          <el-select v-model="newProduct.product_type" placeholder="请选择类型">
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
        </el-form-item>
      </el-form>
      <div class="dialog-footer mt-6">
        <el-button type="primary" @click="addProductFunc">
          <el-icon class="mr-1"><Plus /></el-icon>
          添加商品</el-button
        >
        <el-button type="info" @click="showAddProductDialog = false">
          <el-icon class="mr-1"><Minus /></el-icon>
          取消添加</el-button
        >
      </div>
    </el-dialog>
    <el-dialog v-model="showTypeDialog" width="70%">
      <product-type-table :statistics="typeData" />
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { showAllProducts, addProduct } from "@/api/product.js";
import { showProductTypeTable } from "@/api/statistic.js";
import { useRouter } from "vue-router";
import productBuyItemList from "@c/product/productBuyItemList.vue";
import productImageUpload from "@c/product/productImageUpload.vue";
const products = ref([]);
const router = useRouter();
onMounted(() => {
  showAllProducts({ show_following: 0 }).then((res) => {
    if (res.success) {
      products.value = res.data.products;
    } else {
      router.push({ path: "/404" });
    }
  });
  showProductTypeTable().then((res) => {
    if (res.success) {
      console.log(res.data.statistics);
      typeData.value = res.data.statistics;
    }
  });
});
const showAddProductDialog = ref(false);
const typeData = ref([]);
const newProduct = ref({
  price: 0,
  sell_address: "",
  store: 0,
  product_name: "",
  product_image: "",
  product_press: "",
  product_type: "",
});
const handleImageUploaded = (imageUrl) => {
  newProduct.value.product_image = imageUrl;
};
const showTypeDialog = ref(false);
const addProductFunc = () => {
  addProduct(newProduct.value).then((res) => {
    if (res.success) {
      console.log(res.data);
      ElMessage({
        message: "商品已进入审核列表",
        type: "success",
      });
      showAddProductDialog.value = false;
    } else {
      ElMessage({
        message: res.message,
        type: "error",
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
</style>
