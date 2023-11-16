import request from "@/utils/require";

//get
export function getUser(params) {
  return request({
    url: "/user/list",
    method: "get",
    params,
  });
}

//post
export function editUser(params) {
  return request({
    url: "/user/edit",
    method: "post",
    params,
  });
}

export function registerUser(params) {
  return request({
    url: "/api/register",
    method: "post",
    params,
  });
}
