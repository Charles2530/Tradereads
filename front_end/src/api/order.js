import service from "@/utils/require";

//post

//get
export async function showCurrentUserOrders() {
  return await service({
    url: "/show_current_orders",
    method: "get",
  });
}

export async function showAllOrders() {
  return await service({
    url: "/orders",
    method: "get",
  });
}

//delete（admin only）
export async function deleteOrder(order_id) {
  return await service({
    url: "/orders/" + order_id,
    method: "delete",
  });
}
