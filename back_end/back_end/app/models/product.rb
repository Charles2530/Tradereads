class Product < ApplicationRecord
  belongs_to :user

  validates :price, presence: true, massage: "Price must exist."
  validates :price, numericality: { minimum: 0.0 }, massage: "Price must be non-negative."
  validates :sell_address, presence: true, message: "Sell address must exist."
  validates :store, presence: true
  validates :store, numericality: { minimum: 0 }, massage: "Store must be non-negative."
  validates :state, inclusion: { in: %w(Available StockOut) }

end
