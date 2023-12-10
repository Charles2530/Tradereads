json.extract! notice_record, :id, :notice_id, :user_id, :readed, :created_at, :updated_at
json.url notice_record_url(notice_record, format: :json)
