class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  validates :number, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :state, inclusion:{ in: %w(toPay toDeliver toTake completed) }

end
