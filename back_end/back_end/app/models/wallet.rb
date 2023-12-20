class Wallet < ApplicationRecord
  belongs_to :user
  validates :money_sum, presence: true, numericality: { :greater_than_or_equal_to => 0, :massage => "Money must be non-negative." }
end
