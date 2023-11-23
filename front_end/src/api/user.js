import request from "@/utils/require";

//get
export function logout() {
  return request({
    url: "/logout",
    method: "get",
  });
}

export function getUser(user_id) {
  return request({
    url: "/users/" + user_id,
    method: "get",
  });
}

//post
export function registerUser(params) {
  return request({
    url: "/register",
    method: "post",
    params,
  });
}

export function loginUser(params) {
  return request({
    url: "/login",
    method: "post",
    params,
  });
}

export function modify_password(user_id, params) {
  return request({
    url: "/users/" + user_id + "/modify_password",
    method: "post",
    params,
  });
}

export function modify_username(user_id, params) {
  return request({
    url: "/users/" + user_id + "/modify_username",
    method: "post",
    params,
  });
}

export function modify_address(user_id, params) {
  return request({
    url: "/users/" + user_id + "/modify_address",
    method: "post",
    params,
  });
}
