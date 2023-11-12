<template>
  <div class="product-item bg-white border rounded-lg p-4 flex flex-col">
    <div v-if="!isEditing">
      <div class="mb-2">
        <span class="text-lg font-bold">商品名称: {{ product.title }}</span>
      </div>
      <div class="mb-2">
        <span class="text-gray-600">价格: {{ product.price }}</span>
      </div>
      <div class="mb-2">
        <span>发往: {{ product.shippingAddress }}</span>
      </div>
      <div class="mb-2">
        <p :class="stockClass">{{ stockStatus }}</p>
      </div>
      <button
        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded mt-2"
        @click="toggleEdit"
      >
        编辑商品信息
      </button>
      <button
        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        @click="goToProductDetails(product.id)"
      >
        详细信息
      </button>
    </div>
    <div v-else>
      <!-- Editable view -->
      <div class="mb-4">
        <label for="productName" class="block text-sm font-medium text-gray-700"
          >商品名称</label
        >
        <input
          type="text"
          id="productName"
          v-model="editableProduct.title"
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm"
        />
      </div>
      <div class="mb-4">
        <label
          for="productPrice"
          class="block text-sm font-medium text-gray-700"
          >价格</label
        >
        <input
          type="number"
          id="productPrice"
          v-model.number="editableProduct.price"
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm"
        />
      </div>
      <div class="mb-4">
        <label
          for="shippingAddress"
          class="block text-sm font-medium text-gray-700"
          >发货地址</label
        >
        <input
          type="text"
          id="shippingAddress"
          v-model="editableProduct.shippingAddress"
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm"
        />
      </div>
      <div class="mb-4">
        <label
          for="productStock"
          class="block text-sm font-medium text-gray-700"
          >库存</label
        >
        <input
          type="number"
          id="productStock"
          v-model.number="editableProduct.stock"
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

export default {
  name: "ProductItem",
  props: {
    product: {
      type: Object,
      required: true,
    },
  },
  setup(props, { emit }) {
    const isEditing = ref(false);
    const editableProduct = reactive({ ...props.product });
    const stockClass = computed(() => ({
      "text-red-500": editableProduct.stock === 0,
      "text-green-500": editableProduct.stock > 0,
    }));
    const stockStatus = computed(() =>
      editableProduct.stock > 0 ? "有货" : "售完"
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
      props.$emit("update-product", editableProduct);
      isEditing.value = false; // Exit editing mode
    };

    // Expose the properties and methods to the template
    return {
      isEditing,
      editableProduct,
      stockClass,
      stockStatus,
      goToProductDetails,
      toggleEdit,
      saveEdits,
    };
  },
};
</script>
