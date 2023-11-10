class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :number, presence: true, numericality: { greater_than_or_equal_to: 1 },
            message: "Number of product must be greater than 0."
end
