class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :number, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :state, inclusion:{ in: ["待支付", "待发货", "待收货", "已完成"] }

end
