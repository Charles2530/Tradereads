import service from "@/utils/require";
//post
//get
export async function showProductTypeTable() {
  return await service({
    url: "/product_type_number",
    method: "get",
  });
}

export async function showUserRankTable() {
  return await service({
    url: "/user_sell_rank",
    method: "get",
  });
}
//delete
