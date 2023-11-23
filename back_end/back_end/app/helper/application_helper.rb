# frozen_string_literal: true

module ApplicationHelper

  module Global
    SUCCESS = "Succeeded."
    FAIL = "Failed."
    UNAUTHORIZED = "Unauthorized."
    PORT = 9000
  end

  module ShowError
    extend Global

    SHOW_FAIL = "Show failed."
    SHOW_SUCCEED = "Show succeeded."
  end

  module LoginError
    extend Global

    NO_VALID_INFORMATION_PROVIDED = "Please enter appropriate information."
    WRONG_PASSWORD_PROVIDED = "Password was wrong."
    USER_NOT_EXISTED = "This user is not existed."
    LOGIN_SUCCESS = "Login succeeded."
  end

  module RegisterError
    extend Global

    EXISTED_USER = "This user existed."
    INVALID_INFORMATION = "Register failed."
    REGISTER_SUCCESS = "Register succeeded."
  end

  module ModifyUserError
    extend Global

    MODIFY_USERNAME_SUCCEED = "Modify username succeeded."
    MODIFY_USERNAME_FAIL = "Modify username failed."

    MODIFY_ADDRESS_SUCCEED = "Modify buy address succeeded."
    MODIFY_ADDRESS_FAIL = "Modify buy address failed."

    MODIFY_PASSWORD_SUCCEED = "Modify password succeeded."
    MODIFY_PASSWORD_WRONG_PASSWORD = "Old password was incorrect."
    MODIFY_PASSWORD_FAIL = "Modify password failed."
  end

  module ProductError
    extend Global

    CREATE_FAIL = "Create product failed."
    CREATE_SUCCEED = "Create product succeeded."

    SHOW_PRODUCT_SUCCEED = "Show product succeeded."
    SHOW_PRODUCT_FAIL = "Show product failed."

    SHOW_PRODUCT_LIST_SUCCEED = "Show product list succeeded."
    SHOW_PRODUCT_LIST_FAIL = "Show product list failed."

    MODIFY_UNAVAILABLE = "Only the seller of the product can modify."

    MODIFY_STORE_FAIL = "Modify store failed."
    MODIFY_STORE_SUCCEED = "Modify store succeeded."

    MODIFY_PRICE_FAIL = "Modify price failed."
    MODIFY_PRICE_SUCCEED = "Modify price succeeded."

    MODIFY_ADDRESS_FAIL = "Modify sell address failed."
    MODIFY_ADDRESS_SUCCEED = "Modify sell address succeeded."
  end

  module CartError
    extend Global

    NOT_ENOUGH_STORE = "There are not enough products in store."
    ADD_FAIL = "Add fails."
    ADD_SUCCEED = "Products have been added to cart."
  end

  def response_json(success, message: nil, data: nil)
    {
      success: success,
      message: message || (success ? "Success." : "Fail."),
      data: data
    }
  end
end
