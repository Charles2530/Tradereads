class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :score, inclusion: { in: [0, 1, 2, 3, 4, 5] }
end
