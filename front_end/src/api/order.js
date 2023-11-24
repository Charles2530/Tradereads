import service from "@/utils/require";

//post

//get
export async function addCartsToOrders() {
  return await service({
    url: "/carts_to_orders",
    method: "get",
  });
}

export async function showCurrentUserCart() {
  return await service({
    url: "/show_cart",
    method: "get",
  });
}
