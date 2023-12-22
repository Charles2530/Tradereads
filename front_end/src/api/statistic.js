import service from "@/utils/require";
//post
//get
export async function showProductTypeTable() {
  return await service({
    url: "/product_type_number",
    method: "get",
  });
}
//delete
