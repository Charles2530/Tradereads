class Product < ApplicationRecord
  belongs_to :user
  has_one :product_detail

  validates :price, presence: true, massage: "Price must exist."
  validates :price, numericality: { :greater_than_or_equal_to => 0 }, massage: "Price must be non-negative."
  validates :sell_address, presence: true, message: "Sell address must exist."
  validates :store, presence: true
  validates :store, numericality: { only_integer: true, :greater_than_or_equal_to => 0 }, massage: "Store must be non-negative."
  validates :state, inclusion: { in: %w(Available StockOut) }

end
