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

  def open_user_invites
    @invites = current_user.tournament_invitations.unaccepted
    respond_to do |format|
      format.html { render action: 'show'}
      format.json { render json: @invites}
    end

  end

  def accept_via_secret
    params = accept_via_secret_params

    ti = TournamentInvitation.find(params[:invite_id])
    if (current_user == ti.user && params[:secret_code] == ti.tournament.secret_code)
      ti.accepted = true
      ti.save
      redirect_to root_url, notice: "Thank you for accepting the invitation to #{ti.tournament.name}!  Good luck!"
    else
      redirect_to open_user_invitations_url, notice: "Unable to accept that invitation.  Please check the secret word from the email you received with this invitation."
    end


  end

  private

  def accept_via_secret_params
    params.permit(:invite_id, :secret_code)
  end
end
