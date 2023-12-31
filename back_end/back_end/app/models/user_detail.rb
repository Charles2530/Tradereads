class UserDetail < ApplicationRecord
  belongs_to :user

  validates :user_name, presence: true,
            length: { in: 2..10,  :message => "Please set your name more than 1 letters and less than 11 letters." }

  validates :password, presence: true
  validates :password,
            length: { in: 6..20, message: "The length of password must >=6 and <=20 ." }

  validates :gender, inclusion: { in: %w(male female), message: "%{value} is not available gender." }
  validates :pay_type, inclusion: { in: %w(wechat alipay bank),
                                    message: "Pay type %{value} is not supported." }

end
