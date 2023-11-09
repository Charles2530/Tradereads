class UserDetail < ApplicationRecord
  has_one :user

  validates :user_name, presence: true, length: { in: 2..10 },
            message: "Please set your name more than 1 letters and less than 11 letters."
  validates :gender, inclusion: { in: %w(male female) },
            message: "%{value} is not available gender."
  validates :pay_type, inclusion: { in: %w(Wechat Alipay Paypal Card) },
            message: "Pay type %{value} is not supported."

end
