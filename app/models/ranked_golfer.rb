class RankedGolfer
  include Mongoid::Document
  store_in collection: "rankings"
  field :player, type: String
  field :rank, type: Integer

end