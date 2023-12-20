# frozen_string_literal: true
class UploadController < ApplicationController

  include ApplicationHelper

  def upload_avatar

    baseurl = "https://sm.ms/api/v2"

    user = User.find(params[:user_id])
    post_params = { smfile: params[:file], format: "json" }
    smms_params = post_smms(baseurl + "/upload", post_params)
    puts "smms_params----#{smms_params}"
    unless smms_params
      render json: response_json(
        false,
        message: Global::FAIL
      ) and return
    end
    user_detail = user.user_detail
    puts "data---------#{smms_params['data']}"
    if user_detail.avatar != null

    end
    user_detail.avatar = smms_params['data']['url']
    if user_detail.save
      render status: 200, json: response_json(
        true,
        message: Global::SUCCESS
      )
    else
      render json: response_json(
        false,
        message: Global::FAIL
      )
    end
  end


  def post_smms(url, params)
    res = RestClient::Request.execute(
      method: :post,
      url: url,
      payload: params,
      headers: { 'Content-Type': 'multipart/form-data', Authorization: 'hfdhdmumNaArLcDVnchTjewIYYXgiI8g'}
    )
    case res.code
    when 200
      return JSON.parse(res)
    else
      return nil
    end
  end
end
