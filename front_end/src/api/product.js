import request from "@/utils/require";

export function addProduct(params) {
  return request({
    url: "/products",
    method: "post",
    params,
  });
}

export function getProduct(product_id) {
  return request({
    url: "/products/" + product_id,
    method: "get",
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

export function deleteProduct(product_id) {
  return request({
    url: "/products/" + product_id,
    method: "delete",
  });
}
