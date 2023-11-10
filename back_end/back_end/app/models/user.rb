class User < ApplicationRecord
  has_one :user_detail
  has_many :products
  has_many :carts
  has_many :orders

  # phone must be series of number
  validates :phone, presence: true, length: { in: 3..20 } ,
            numericality: { only_integer: true}
  validates :right, presence: true, inclusion: { in: [0,1] }

end
