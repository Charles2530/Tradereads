import service from "@/utils/require";

//post

//get
export async function addComment(product_id, params) {
  return await service({
    url: "/products/" + product_id + "/comments",
    method: "post",
    params,
  });
}
//delete
export async function deleteComment(comment_id) {
  return await service({
    url: "/comments/" + comment_id,
    method: "delete",
  });
}
