import service from "@/utils/require";

//post
export async function createNotice(params) {
  return await service({
    url: "/notices",
    method: "post",
    params,
  });
}

//get
export async function showCurrentNotices() {
  return await service({
    url: "/notices",
    method: "get",
  });
}

//delete
