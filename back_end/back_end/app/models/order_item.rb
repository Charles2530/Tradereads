class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :number, presence: true, numericality: { greater_than_or_equal_to: 1 }
end
