class ProductDetail < ApplicationRecord
  belongs_to :product

  validates :product_name, presence: true, length: { in: 1..20 }
  validates :product_type, inclusion: { in: %w(art math literature history novel) }

end
