class User < ApplicationRecord
  has_one :user_detail
  has_many :products

  # phone must be series of number
  validates :phone, presence: true, length: { in: 3..20 } ,
            numericality: { only_integer: true}


end
