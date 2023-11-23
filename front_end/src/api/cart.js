import request from "@/utils/require";

export function showCurrentUserCart() {
  return request({
    url: "/show_cart",
    method: "get",
  });
}

export function addCartsToOrders() {
  return request({
    url: "/carts_to_orders",
    method: "post",
  });
}
