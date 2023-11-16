import request from "@/utils/require";

//get
export function getUser(user_id) {
  return request({
    url: "/users/" + user_id,
    method: "get",
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
    url: "/register",
    method: "post",
    params,
  });
}
