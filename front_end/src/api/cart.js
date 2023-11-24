import request from "@/utils/require";

//post

export function addCartsToOrders() {
  return request({
    url: "/carts_to_orders",
    method: "post",
  });
}

//get
export function showCurrentUserCart() {
  return request({
    url: "/show_cart",
    method: "get",
  });
}
