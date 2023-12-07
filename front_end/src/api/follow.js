import service from "@/utils/require";

//post

//get
export async function Follow(user_id) {
  return await service({
    url: "users/" + user_id + "/follow_user",
    method: "get",
  });
}
export async function showCurrentUserFollowings(user_id) {
  return await service({
    url: "users/" + user_id + "/follow_list",
    method: "get",
  });
}
export async function IsFollow(user_id) {
  return await service({
    url: "users/" + user_id + "/if_follow",
    method: "get",
  });
}

//delete
