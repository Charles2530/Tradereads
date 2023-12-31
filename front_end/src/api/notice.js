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

export async function unReadNotice() {
  return await service({
    url: "/have_new_notice",
    method: "get",
  });
}

//delete
