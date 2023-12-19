import service from "@/utils/require";

// get
export async function showWallet() {
  let response = await service({
    url: "/wallet",
    method: "get",
  });
  return response;
}

// post
export async function addMoney(params) {
  let response = await service({
    url: "/wallet_charge",
    method: "post",
    params,
  });
  return response;
}
