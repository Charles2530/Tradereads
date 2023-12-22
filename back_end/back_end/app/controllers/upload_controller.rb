# frozen_string_literal: true
class UploadController < ApplicationController

  include ApplicationHelper

  def upload_image
    baseurl = "https://sm.ms/api/v2"

    post_params = { smfile: params[:file], format: "json" }
    smms_params = post_smms(baseurl + "/upload", post_params)
    puts "smms_params----#{smms_params}"
    unless smms_params
      render json: response_json(
        false,
        message: Global::FAIL
      ) and return
    end
    if smms_params['success'] == false
      if smms_params['image_repeated']
        url = smms_params['images']
      else
        render json: response_json(
          false,
          message: "上传失败"
        ) and return
      end
    else
      url = smms_params['data']['url']
    end
    puts "data---------#{smms_params['data']}"
    render status: 200, json: response_json(
      true,
      message: Global::SUCCESS,
      data: {
        image_url: url
      }
    )
  end

  def upload_avatar

    baseurl = "https://sm.ms/api/v2"

    user = User.find(params[:user_id])
    post_params = { smfile: params[:file], format: "json" }
    smms_params = post_smms(baseurl + "/upload", post_params)
    puts "smms_params----#{smms_params}"
    unless smms_params
      render json: response_json(
        false,
        message: "上传失败"
      ) and return
    end
    if smms_params['success'] == false
      if smms_params['image_repeated']
        url = smms_params['images']
      else
        render json: response_json(
          false,
          message: "上传失败"
        ) and return
      end
    else
      url = smms_params['data']['url']
    end
    user_detail = user.user_detail
    puts "data---------#{smms_params['data']}"
    user_detail.avatar = url
    if user_detail.save
      render status: 200, json: response_json(
        true,
        message: Global::SUCCESS
      )
    else
      render json: response_json(
        false,
        message: "上传失败"
      )
    end
  end

  def product_type_number
    names = %w(杂志 教科书 小说 童话 戏剧 数学 计算机 漫画 自传)
    values = []
    names.each do |name|
      values << ProductDetail.where(product_type: name).length
    end
    i = -1
    render status: 200, json: response_json(
      true,
      message: Global::SUCCESS,
      data: {
        statistics: names.collect do |name|
          i += 1
          {
            value: values[i],
            name: name
          }
        end
      }
    )


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
