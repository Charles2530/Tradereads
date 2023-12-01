class ApplicationController < ActionController::API
  # helper_mothod :current_user
  # include ::ActionController::Cookies
  Encoding.default_internal="UTF-8"

  public

  def setAdmin
    unless @admin
      @admin = User.new(right: 1, phone: "13612345678")
      detail = UserDetail.new(user: @admin, password: "adminadmin", user_name: "admin", gender: "male",
                              pay_type: "Alipay")
      @admin.save
      detail.save
    end
  end

  def current_user
    @current_user ||= User.find(session[:current_userid]) if session[:current_userid]
  end

  def login_only
    if current_user
      true
    else
      render status: 401, json: response_json(
        false,
        message: "Please login firstly!"
      )
      false
    end
  end

  def unlogin_only
    if not current_user
      true
    else
      render status: 403, json: response_json(
        false,
        message: "You have logged in!"
      )
    end
  end


end
