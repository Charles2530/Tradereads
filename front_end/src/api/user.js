import service from "@/utils/require";

//get
export async function logout() {
  let response = await service({
    url: "/logout",
    method: "get",
  });
  return response;
}

export async function getUser(user_id) {
  let response = await service({
    url: "/users/" + user_id,
    method: "get",
  });
  return response;
}

export async function showAllUserList() {
  let response = await service({
    url: "/users",
    method: "get",
  });
  return response;
}

//post
export async function registerUser(params) {
  let response = await service({
    url: "/register",
    method: "post",
    params,
  });
  return response;
}

export async function loginUser(params) {
  let response = await service({
    url: "/login",
    method: "post",
    params,
  });
  return response;
}

export async function modify_password(user_id, params) {
  let response = await service({
    url: "/users/" + user_id + "/modify_password",
    method: "post",
    params,
  });
  return response;
}

export async function modify_username(user_id, params) {
  let response = await service({
    url: "/users/" + user_id + "/modify_username",
    method: "post",
    params,
  });
  return response;
}

export async function modify_address(user_id, params) {
  let response = await service({
    url: "/users/" + user_id + "/modify_address",
    method: "post",
    params,
  });
  return response;
}

export async function modify_payType(user_id, params) {
  let response = await service({
    url: "/users/" + user_id + "/modify_pay_type",
    method: "post",
    params,
  });
  return response;
}

export async function uploadAvatar(user_id, params) {
  let response = await service({
    url: "/users/" + user_id + "/upload_avatar",
    method: "post",
    params,
  });
  return response;
}
