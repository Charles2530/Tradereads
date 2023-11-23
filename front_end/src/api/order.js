import request from "@/utils/require";

export function showCurrentUserOrders() {
  return request({
    url: "/show_current_orders",
    method: "get",
  });
}

export function showAllOrders() {
  return request({
    url: "/orders",
    method: "get",
  });
}

export function deleteOrder(order_id) {
  return request({
    url: "/orders/" + order_id,
    method: "delete",
  });
}
