import service from "@/utils/require";

//post
export async function ExamineProduct(product_id, params) {
  return await service({
    url: "/products/" + product_id + "/check_product",
    method: "post",
    params,
  });
}

//get
export async function showExamineList() {
  return await service({
    url: "/products/check_product",
    method: "get",
  });
}
//delete
