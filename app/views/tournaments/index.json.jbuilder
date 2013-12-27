json.array!(@tournaments) do |tournament|
  json.extract! tournament, :id
  json.url tournament_url(tournament, format: :json)
  json.extract! tournament, :name, :start_date, :end_date, :picks_start, :picks_end
  json.admin tournament.admin
end
