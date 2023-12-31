import service from "@/utils/require";

//post
export async function addCartsToOrders(params) {
  return await service({
    url: "/choose_cart_to_order",
    method: "post",
    params,
  });
}

//get

export async function showCurrentUserCart() {
  return await service({
    url: "/show_cart",
    method: "get",
  });
}

export async function clearCurrentUserCart() {
  return await service({
    url: "/carts_to_orders",
    method: "get",
  });
}

//delete
export async function removeFromCart(product_id) {
  return await service({
    url: "/products/" + product_id + "/remove_from_cart",
    method: "delete",
  });
}
