class NoticeRecord < ApplicationRecord
  belongs_to :notice
  belongs_to :user
end
