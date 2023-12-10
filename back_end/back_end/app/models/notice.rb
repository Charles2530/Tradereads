class Notice < ApplicationRecord
  belongs_to :user
  has_many :notice_records

  validates :type, inclusion:{ in: [1, 2] }
end
