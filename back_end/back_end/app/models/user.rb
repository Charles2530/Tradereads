class User < ApplicationRecord
  has_one :user_detail, dependent: :destroy
  has_one :wallet, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :followships, dependent: :destroy
  has_many :reverse_followships, class_name: "Followship", foreign_key: "following_user_id"
  has_many :followings, through: :followships
  has_many :followers, through: :reverse_followships
  has_many :comments, dependent: :destroy
  has_many :notices, dependent: :destroy
  has_many :notice_records



  # phone must be series of number
  validates :phone, presence: true, length: { in: 3..20 } ,
            numericality: { only_integer: true} ,
            uniqueness: true
  validates :right, presence: true, inclusion: { in: [0,1] }

end
