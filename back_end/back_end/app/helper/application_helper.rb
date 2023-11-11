# frozen_string_literal: true

module ApplicationHelper

  module Global
    SUCCESS = "success"
    PORT = 9000
  end

  module LoginError
    extend Global

    NO_VALID_INFORMATION_PROVIDED = "Please enter appropriate information"
    WRONG_PASSWORD_PROVIDED = "Password is wrong"
    USER_NOT_EXISTED = "This user is not existed"
    LOGIN_SUCCESS = "Login Success"
  end

  module RegisterError
    extend Global

    EXISTED_USER = "This user existed"
    INVALID_INFORMATION = "Register Fail"
    REGISTER_SUCCESS = "Register Success"
  end

  def response_json(success, message: nil, data: nil)
    {
      success: success,
      message: message || (success ? "Success." : "Fail."),
      data: data
    }
  end
end
