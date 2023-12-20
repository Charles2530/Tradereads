<template>
  <div>
    <navigation-bar></navigation-bar>
    <div
      class="bg-productBuyCenter-background bg-cover bg-center bg-no-repeat p-4 min-h-screen pl-12"
    >
      <div style="position: relative; z-index: 1">
        <personal-center-side-bar />
      </div>
      <div class="container mx-auto p-4" style="position: relative; z-index: 0">
        <div class="mb-4 ml-16">
          <h1 class="text-3xl font-semibold mb-2 text-white">二手书商品中心</h1>
          <p class="text-gray-200 notice-detail">快来选购你想要的二手书吧!</p>
          <el-button
            class="mt-2"
            type="primary"
            plain
            @click="showAddProductDialog = true"
            >发布商品</el-button
          >
        </div>
        <div class="user-management mx-20 bg-white rounded-xl">
          <product-buy-item-list :products="products" />
        </div>
      </div>
    </div>
    <el-dialog title="添加商品" v-model="showAddProductDialog" width="30%">
      <el-form :model="newProduct" ref="newProductForm" label-width="120px">
        <el-form-item label="价格" prop="price">
          <el-input-number v-model="newProduct.price"></el-input-number>
        </el-form-item>
        <el-form-item label="出售地址" prop="sell_address">
          <el-input v-model="newProduct.sell_address"></el-input>
        </el-form-item>
        <el-form-item label="库存" prop="store">
          <el-input-number v-model="newProduct.store"></el-input-number>
        </el-form-item>
        <el-form-item label="商品名称" prop="product_name">
          <product-image-upload @image-uploaded="handleImageUploaded" />
        </el-form-item>
        <el-form-item label="商品图片" prop="product_image">
          <el-input v-model="newProduct.product_image"></el-input>
        </el-form-item>
        <el-form-item label="商品出版社" prop="product_press">
          <el-input v-model="newProduct.product_press"></el-input>
        </el-form-item>
        <el-form-item label="商品类型" prop="product_type">
          <el-input v-model="newProduct.product_type"></el-input>
        </el-form-item>
      </el-form>
      <div class="dialog-footer mt-6">
        <el-button type="primary" @click="addProductFunc">添加商品</el-button>
        <el-button @click="showAddProductDialog = false">取消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { showAllProducts, addProduct } from "@/api/product.js";
import productBuyItemList from "@c/product/productBuyItemList.vue";
import productImageUpload from "@c/product/productImageUpload.vue";
const products = ref([]);

onMounted(() => {
  showAllProducts({ show_following: 0 }).then((res) => {
    if (res.success) {
      products.value = res.data.products;
    }
  });
});
const showAddProductDialog = ref(false);
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
const addProductFunc = () => {
  addProduct(newProduct.value).then((res) => {
    if (res.success) {
      console.log(res.data);
      ElMessage({
        message: "添加商品成功",
        type: "success",
      });
      showAddProductDialog.value = false;
      products.value.push(res.data);
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
