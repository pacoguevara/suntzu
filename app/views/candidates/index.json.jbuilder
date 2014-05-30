json.array!(@candidates) do |candidate|
  json.extract! candidate, :id, :name, :age, :sex
  json.url candidate_url(candidate, format: :json)
end
