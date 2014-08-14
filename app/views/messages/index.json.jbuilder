json.array!(@messages) do |message|
  json.extract! message, :id, :user_id, :message, :deep
  json.url message_url(message, format: :json)
end
