class Notice < ApplicationRecord
  belongs_to :user
  has_many :notice_records, dependent: :destroy

  validates :notice_type, inclusion:{ in: [1, 2, 3] }
end
