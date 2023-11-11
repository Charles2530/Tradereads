class User < ApplicationRecord
  has_one :user_detail, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :orders, dependent: :destroy

  # phone must be series of number
  validates :phone, presence: true, length: { in: 3..20 } ,
            numericality: { only_integer: true}
  validates :right, presence: true, inclusion: { in: [0,1] }

end
