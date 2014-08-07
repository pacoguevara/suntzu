json.array!(@pollings) do |polling|
  json.extract! polling, :id, :name, :start_date, :end_date
  json.url polling_url(polling, format: :json)
end
