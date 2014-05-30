json.array!(@militants) do |militant|
  json.extract! militant, :id, :register_date, :first_name, :last_name, :name, :bird, :rnm, :linking, :sub_linking, :group_id, :suburb, :section, :sector, :cp, :phone, :cellphone, :email
  json.url militant_url(militant, format: :json)
end
