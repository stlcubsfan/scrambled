class TournamentGolfer
  include Mongoid::Document
  store_in collection: "tournament_golfers"
  field :tournament_id, type: Integer
  field :player, type: String
  field :rank, type: Integer

end