<template>
  <div class="product-item bg-white border rounded-lg p-4 flex flex-col">
    <div v-if="!isEditing">
      <el-row class="mb-2">
        <el-col :span="24">
          <span class="text-lg font-bold"
            >商品名称: {{ product.product_name }}</span
          >
        </el-col>
      </el-row>

      <el-row class="mb-2">
        <el-col :span="12" class="mb-2">
          <el-row class="mb-5">
            <span class="text-gray-600">价格: {{ product.price }}</span>
          </el-row>
          <el-row class="mb-5">
            <span class="text-gray-600"
              >商品库存: {{ product.product_store }}</span
            >
          </el-row>
          <el-row class="mb-5">
            <span class="text-gray-600"
              >发货地址: {{ product.sell_address }}</span
            >
          </el-row>
          <el-row class="mb-5 text-xl">
            <span :class="stockClass">{{ stockStatus }}</span>
            <span :class="examineClass">{{ examineStatus }}</span>
          </el-row>
        </el-col>
        <el-col :span="12" class="text-center">
          <div>
            <img
              :src="product.product_image"
              alt="Product Image"
              class="w-48 h-48"
            />
          </div>
        </el-col>
      </el-row>
      <button
        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded mt-2 mr-2"
        @click="toggleEdit"
      >
        <el-icon class="mr-2"><Histogram /></el-icon>
        编辑商品信息
      </button>
      <button
        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        @click="goToProductDetails(product.id)"
      >
        <el-icon class="mr-2"><Promotion /></el-icon>
        详细信息
      </button>
    </div>
    <div v-else>
      <!-- Editable view -->
      <div class="mb-4">
        <label for="productName" class="block text-sm font-medium text-gray-700"
          >商品名称</label
        >
        <el-input
          type="text"
          id="productName"
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm"
          v-model="editableProduct.product_name"
          placeholder="Please input"
          clearable
        />
      </div>
      <div class="mb-4">
        <label
          for="productPrice"
          class="block text-sm font-medium text-gray-700"
          >价格</label
        >
        <el-input
          type="number"
          id="productPrice"
          v-model.number="editableProduct.price"
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm"
        />
      </div>
      <div class="mb-4">
        <label
          for="product_image"
          class="block text-sm font-medium text-gray-700"
          >商品图片</label
        >
        <el-input
          type="text"
          id="product_image"
          v-model="editableProduct.product_image"
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm"
        />
      </div>
      <div class="mb-4">
        <label
          for="product_store"
          class="block text-sm font-medium text-gray-700"
          >库存</label
        >
        <el-input
          type="number"
          id="product_store"
          v-model.number="editableProduct.product_store"
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm"
        />
      </div>
      <div class="mb-4">
        <label
          for="sell_address"
          class="block text-sm font-medium text-gray-700"
          >发货地址</label
        >
        <el-input
          type="text"
          id="sell_address"
          v-model="editableProduct.sell_address"
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm"
        />
      </div>
      <span :class="stockClass">{{ stockStatus }}</span>
      <button
        class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded mt-2"
        @click="saveEdits"
      >
        保存编辑
      </button>
      <button
        class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded mt-2"
        @click="toggleEdit"
      >
        取消
      </button>
    </div>
  </div>
</template>

<script>
import { ref, reactive, computed } from "vue";
import {
  modifyStorage,
  modifyPrice,
  modifySellAddress,
} from "@/api/product.js";

export default {
  name: "ProductItem",
  props: {
    product: {
      type: Object,
      required: true,
    },
  },
  setup(props) {
    const isEditing = ref(false);
    const editableProduct = reactive({ ...props.product });
    const stockClass = computed(() => ({
      "text-red-500 mx-2": editableProduct.product_store === 0,
      "text-green-500 mx-2": editableProduct.product_store > 0,
    }));
    const examineClass = computed(() => ({
      "text-red-500 mx-2": editableProduct.check_state === false,
      "text-green-500 mx-2": editableProduct.check_state === true,
    }));
    const stockStatus = computed(() =>
      editableProduct.product_store > 0 ? "有货" : "售完"
    );
    const examineStatus = computed(() =>
      !editableProduct.check_state ? "未审核" : "已审核"
    );

    const goToProductDetails = (productId) => {
      // Replace with your router logic or window location change
      // this.$router.push(`/product/${productId}`);
    };

    const toggleEdit = () => {
      if (isEditing.value) {
        // Revert changes if canceling edit
        Object.assign(editableProduct, props.product);
      }
      isEditing.value = !isEditing.value;
    };

    const saveEdits = () => {
      // Emit an event with the updated product info
      console.log(editableProduct);
      modifyPrice(editableProduct.product_id, {
        new_price: editableProduct.price,
      }).then((res) => {
        console.log(res);
        if (res.success) {
          console.log("修改价格成功");
        } else {
          ElMessage({
            message: res.message,
            type: "error",
          });
        }
      });

      modifySellAddress(editableProduct.product_id, {
        new_address: editableProduct.sell_address,
      }).then((res) => {
        console.log(res);
        if (res.success) {
          console.log("修改地址成功");
        } else {
          ElMessage({
            message: res.message,
            type: "error",
          });
        }
      });

      modifyStorage(editableProduct.product_id, {
        new_store: editableProduct.product_store,
      }).then((res) => {
        console.log(res);
        if (res.success) {
          console.log("修改库存成功");
        } else {
          ElMessage({
            message: res.message,
            type: "error",
          });
        }
      });
      isEditing.value = false; // Exit editing mode
      // flush page
      window.location.reload();
    };

    // Expose the properties and methods to the template
    return {
      isEditing,
      editableProduct,
      stockClass,
      stockStatus,
      examineClass,
      examineStatus,
      goToProductDetails,
      toggleEdit,
      saveEdits,
    };
  },
};
</script>
