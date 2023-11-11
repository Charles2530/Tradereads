class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :number, presence: true, numericality: { greater_than_or_equal_to: 1 }
end
