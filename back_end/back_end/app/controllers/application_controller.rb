class ApplicationController < ActionController::API
  # helper_mothod :current_user
  # include ::ActionController::Cookies
  Encoding.default_internal="UTF-8"

  public

  def setAdmin
    if User.find_by(phone: "13612345678")
      @admin = User.find_by(phone: "13612345678")
    else
      @admin = User.new(right: 1, phone: "13612345678")
      detail = UserDetail.new(user: @admin, password: "adminadmin", user_name: "admin", gender: "male",
                              pay_type: "alipay")
      wallet = Wallet.new(user: @admin, money_sum: 0.00)
      @admin.save
      detail.save
      wallet.save
    end
  end

  def set_current_user(user)
    ApplicationRecord.current_user = user
  end

  def current_user
    ApplicationRecord.current_user
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
