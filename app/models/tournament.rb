class Tournament < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :picks_start, presence: true
  validates :picks_end, presence: true
  validates :par, presence: true, numericality: { only_integer: true, greater_than: 0 }


  belongs_to :admin
  has_many :tournament_invitations

  def golfers
    @golfers = TournamentGolfer.where(:tournament_id => self.id).order_by(:rank.asc)
  end

  def a_golfers
    TournamentGolfer.where(tournament_id: self.id).between(rank: 1..5)
  end

  def b_golfers
    TournamentGolfer.where(tournament_id: self.id).between(rank: 6..20)
  end

  def c_golfers
    TournamentGolfer.where(tournament_id: self.id).between(rank: 21..50)
  end

  def d_golfers
    TournamentGolfer.where(tournament_id: self.id).gte(rank: 51)
  end

end
