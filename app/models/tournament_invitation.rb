class TournamentInvitation < ActiveRecord::Base
  before_create :create_invite_code

  belongs_to :user
  belongs_to :tournament

  def accepted?
    accepted
  end

  def create_invite_code
    self.invite_code = SecureRandom.uuid
  end
end
