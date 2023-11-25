class ApplicationController < ActionController::API
  # helper_mothod :current_user
  # include ::ActionController::Cookies

  public

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
