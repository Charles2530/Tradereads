import service from "@/utils/require";

//post
export async function modifyOrderStatus(order_item_id, params) {
  return await service({
    url: "/order_items/" + order_item_id + "/modify_order_item_state",
    method: "post",
    params,
  });
}

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

export async function showSellOrders() {
  return await service({
    url: "/show_sell_orders",
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
