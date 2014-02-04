class InvitationMailer < ActionMailer::Base
  default from: "stlcubsfan@gmail.com"

  def tournament_invitation(tournament_invitation)
    @user = tournament_invitation.user
    @tournament = tournament_invitation.tournament
    @code = tournament_invitation.invite_code
    mail(to: @user.email, subject: 'Scrambled Tournament Invitation')
  end
end
