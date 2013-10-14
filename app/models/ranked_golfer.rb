class RankedGolfer
  include Mongoid::Document
  store_in collection: "rankedGolfers"
  field :rank, type: Integer
  field :name, type: String

  def self.agolfers
    RankedGolfer.where(:rank.lte => 5)
  end

  def self.bgolfers
    RankedGolfer.where(:rank.gte => 6).where(:rank.lte => 20)
  end
  def self.cgolfers
    RankedGolfer.where(:rank.gte => 21).where(:rank.lte => 50)
  end

  def self.dgolfers
    RankedGolfer.where(:rank.gte => 51)
  end
end
