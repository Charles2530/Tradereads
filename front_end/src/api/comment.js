import service from "@/utils/require";

//post
export async function addComment(product_id, params) {
  return await service({
    url: "/products/" + product_id + "/add_comment",
    method: "post",
    params,
  });
}
//get

export async function showComment(product_id) {
  return await service({
    url: "/products/" + product_id + "/show_comments",
    method: "get",
  });
}

//delete
export async function deleteComment(comment_id) {
  return await service({
    url: "/comments/" + comment_id,
    method: "delete",
  });
}
