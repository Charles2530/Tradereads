import request from "@/utils/require";

//post
export function addProduct(params) {
  return request({
    url: "/products",
    method: "post",
    params,
  });
}

export function modifyStorage(product_id, params) {
  return request({
    url: "/products/" + product_id + "modify_store",
    method: "post",
    params,
  });
}

export function modifyPrice(product_id, params) {
  return request({
    url: "/products/" + product_id + "modify_price",
    method: "post",
    params,
  });
}

export function modifySellAddress(product_id, params) {
  return request({
    url: "/products/" + product_id + "modify_sell_address",
    method: "post",
    params,
  });
}

export function addProductToCart(product_id, params) {
  return request({
    url: "/products/" + product_id + "add_product_to_cart",
    method: "post",
    params,
  });
}

//get
export function showAllProducts() {
  return request({
    url: "/products",
    method: "get",
  });
}

export function getProduct(product_id) {
  return request({
    url: "/products/" + product_id,
    method: "get",
  });
}

export function showProductsList(user_id) {
  return request({
    url: "/users/" + user_id + "/show_product_list",
    method: "get",
  });
}

//delete
export function deleteProduct(product_id) {
  return request({
    url: "/products/" + product_id,
    method: "delete",
  });
}
