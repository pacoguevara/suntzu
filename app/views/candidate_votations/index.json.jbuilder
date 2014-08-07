json.array!(@candidate_votations) do |candidate_votation|
  json.extract! candidate_votation, :id
  json.url candidate_votation_url(candidate_votation, format: :json)
end
