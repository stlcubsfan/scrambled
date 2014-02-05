class Tournament < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :picks_start, presence: true
  validates :picks_end, presence: true

  belongs_to :admin
  has_many :tournament_invitations

  def golfers
    @golfers = TournamentGolfer.where(:tournament_id => self.id).order_by(:rank.asc)
  end
end
