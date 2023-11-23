import request from "@/utils/require";

//post

//get
export function addCartsToOrders() {
  return request({
    url: "/carts_to_orders",
    method: "get",
  });
}

export function showCurrentUserCart() {
  return request({
    url: "/show_cart",
    method: "get",
  });
}
