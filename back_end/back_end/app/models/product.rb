class Product < ApplicationRecord
  belongs_to :user
  has_one :product_detail, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :price,
            :presence => { massage: "Price must exist." }
  validates :price, numericality: { :greater_than_or_equal_to => 0, :massage => "Price must be non-negative." }
  validates :sell_address,
            :presence => { massage: "Price must exist." }
  validates :store, presence: true
  validates :store, numericality: { only_integer: true, :greater_than_or_equal_to => 0, :massage => "Store must be non-negative." }
  validates :state, inclusion: { in: %w(Available StockOut) }

end
