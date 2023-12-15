json.extract! notice, :id, :title, :type, :user_id, :content, :created_at, :updated_at
json.url notice_url(notice, format: :json)
