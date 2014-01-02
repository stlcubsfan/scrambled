class AcceptInvitationController < ApplicationController
  def index
    ti = TournamentInvitation.find_by_invite_code(params[:id])
    if ti
      ti.accepted = true
      ti.save
      sign_in(ti.user)
      redirect_to root_url, notice: "Thank you for accepting the invitation to #{ti.tournament.name}!  Good luck!"
    else
      redirect_to root_url, notice: "Unable to accept that invitation at this time"
    end


  end
end
