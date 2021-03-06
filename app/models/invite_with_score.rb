class InviteWithScore
  attr_accessor :name, :agolfer, :bgolfer, :cgolfer, :dgolfer,
                :agolferScore, :bgolferScore, :cgolferScore, :dgolferScore,
                :agolferStatus, :bgolferStatus, :cgolferStatus, :dgolferStatus,
                :totalScore, :agolferThru, :bgolferThru, :cgolferThru, :dgolferThru

  def initialize(invite)
    @agolfer = invite.agolfer
    @bgolfer = invite.bgolfer
    @cgolfer = invite.cgolfer
    @dgolfer = invite.dgolfer
    @name = "#{invite.user.first_name} #{invite.user.last_name}"
    @agolferScore = 0
    @bgolferScore = 0
    @cgolferScore = 0
    @dgolferScore = 0
    @agolferStatus = 'active'
    @bgolferStatus = 'active'
    @cgolferStatus = 'active'
    @dgolferStatus = 'active'

  end

  def totalScore
    @agolferScore + @bgolferScore + @cgolferScore + @dgolferScore
  end


end