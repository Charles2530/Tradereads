import service from "@/utils/require";

//post
export async function addProduct(params) {
  return await service({
    url: "/products",
    method: "post",
    params,
  });
}

export async function modifyStorage(product_id, params) {
  return await service({
    url: "/products/" + product_id + "/modify_store",
    method: "post",
    params,
  });
}

export async function modifyPrice(product_id, params) {
  return await service({
    url: "/products/" + product_id + "/modify_price",
    method: "post",
    params,
  });
}

export async function modifySellAddress(product_id, params) {
  return await service({
    url: "/products/" + product_id + "/modify_sell_address",
    method: "post",
    params,
  });
}

export async function modifyProductName(product_id, params) {
  return await service({
    url: "/products/" + product_id + "/modify_product_name",
    method: "post",
    params,
  });
}

export async function addProductToCart(product_id, params) {
  return await service({
    url: "/products/" + product_id + "/add_product_to_cart",
    method: "post",
    params,
  });
}

export async function buyProduct(product_id, params) {
  return await service({
    url: "/products/" + product_id + "/buy_product",
    method: "post",
    params,
  });
}
//get
export async function showAllProducts(params) {
  return await service({
    url: "/show_products",
    method: "post",
    params,
  });
}

export async function getProduct(product_id) {
  return await service({
    url: "/products/" + product_id,
    method: "get",
  });
}

export async function showProductsList(user_id) {
  return await service({
    url: "/users/" + user_id + "/show_product_list",
    method: "get",
  });
}

export async function showComments(product_id) {
  return await service({
    url: "/products/" + product_id + "/show_comments",
    method: "get",
  });
}

//delete
export async function deleteProduct(product_id) {
  return await service({
    url: "/products/" + product_id,
    method: "delete",
  });
}
