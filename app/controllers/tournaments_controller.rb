class TournamentsController < ApplicationController
  require 'mechanize'

  before_filter :authenticate_admin!, except: [:upcoming, :user_tournaments, :mine, 
			:agolfers, :bgolfers, :cgolfers, :dgolfers, :user_tournament_invitation, :standings
		]
  before_action :set_tournament, only: [:show, :edit, :update, :destroy,
                                        :uninvited_users, :invite_users, :freeze_golfers,
                                        :agolfers, :bgolfers, :cgolfers, :dgolfers,
                                        :user_tournament_invitation, :standings]

  # GET /tournaments
  # GET /tournaments.json
  def index
    @tournaments = Tournament.all.order(:start_date)
  end

  # GET /tournaments/1
  # GET /tournaments/1.json
  def show
    uninvited_users
  end

  # GET /tournaments/new
  def new
    @tournament = Tournament.new
  end

  # GET /tournaments/1/edit
  def edit
  end

  # POST /tournaments
  # POST /tournaments.json
  def create
    @tournament = Tournament.new(tournament_params)
    @tournament.admin = current_admin
    respond_to do |format|
      if @tournament.save
        format.html { redirect_to @tournament, notice: 'Tournament was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tournament }
      else
        format.html { render action: 'new' }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tournaments/1
  # PATCH/PUT /tournaments/1.json
  def update
    respond_to do |format|
      @tournament.admin = current_admin
      if @tournament.update(tournament_params)
        format.html { redirect_to @tournament, notice: 'Tournament was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournaments/1
  # DELETE /tournaments/1.json
  def destroy
    @tournament.destroy
    respond_to do |format|
      format.html { redirect_to tournaments_url }
      format.json { head :no_content }
    end
  end

  def upcoming
    @tournaments = Tournament.where("end_date >= ?", Time.now).order("start_date")
    render json: @tournaments
  end

  def previous
    @tournaments = Tournament.where("end_date <= ?", Time.now).order("start_date desc")
    render json: @tournaments
  end

  def current
    @tournaments = Tournament.where("start_date <= ? and end_date >= ?", Time.now, Time.now).order("start_date")
    render json: @tournaments
  end


  def mine

  end

  def user_tournaments
    if user_signed_in?
      tournaments =  current_user.tournament_invitations.accepted.collect do |ti|
        ti.tournament.secret_code = "{it's a secret}"
        ti.tournament
      end
      render json: tournaments

    else
      render json: []
    end

  end

  def user_tournament_invitation
    if user_signed_in?
      invite = TournamentInvitation.find_by_tournament_id_and_user_id(params["id"], current_user.id)
      render json: invite
    end
  end

  def update_invitation_with_golfers
    invite_params = golfers_for_invitation_params

    invitation = TournamentInvitation.find_by_tournament_id_and_user_id(invite_params["tournament_id"], current_user.id)

    if invitation && invitation.user == current_user
      invitation.agolfer = invite_params["agolfer"]
      invitation.bgolfer = invite_params["bgolfer"]
      invitation.cgolfer = invite_params["cgolfer"]
      invitation.dgolfer = invite_params["dgolfer"]
      invitation.save
      render json: invitation
    end
  end

  def agolfers
    render json: @tournament.a_golfers
  end

  def bgolfers
    render json: @tournament.b_golfers
  end

  def cgolfers
    render json: @tournament.c_golfers
  end

  def dgolfers
    render json: @tournament.d_golfers
  end
  def freeze_golfers
    golfers = RankedGolfer.all
    TournamentGolfer.delete_all(tournament_id: @tournament.id)
    golfers.each do |g|
      tg = TournamentGolfer.new
      tg.player = g.player
      tg.rank = g.rank
      tg.tournament_id = @tournament.id
      tg.save
    end
    redirect_to @tournament, notice: "Golfers have been frozen"
  end

  def invite_users
    users = params[:invite].keys
    users.each do |u|
      begin
        user = User.find(u)
        ti = TournamentInvitation.new
        ti.tournament = @tournament
        ti.user = User.find(u)
        ti.save
        InvitationMailer.tournament_invitation(ti).deliver
      rescue Exception => e
        logger.error e.message
      end


    end
    redirect_to @tournament, notice: "Successfully sent invitations"
  end

  def uninvited_users
    @uninvited_users = User.all
    invited_users = @tournament.tournament_invitations.collect {|ti| ti.user}
    @uninvited_users -= invited_users
  end

  def standings
    invites = @tournament.tournament_invitations
    @invites_plus_scores = []
    current_scores = get_scores(@tournament)
    invites.each do |i|
      invite = InviteWithScore.new(i)
      invite.agolferScore = current_scores[invite.agolfer]  || 0
      invite.bgolferScore = current_scores[invite.bgolfer]  || 0
      invite.cgolferScore = current_scores[invite.cgolfer]  || 0
      invite.dgolferScore = current_scores[invite.dgolfer]  || 0
      invite.totalScore = invite.totalScore
      @invites_plus_scores << invite
    end

    render json: @invites_plus_scores
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tournament_params
      params.require(:tournament).permit(:name, :start_date, :end_date, :picks_start, :picks_end, :secret_code, :leaderboard_url)
    end

    def golfers_for_invitation_params
      params.require(:picks).permit(:tournament_id, :agolfer, :bgolfer, :cgolfer, :dgolfer)
    end

    def get_scores(tournament)
      agent = Mechanize.new
      scores = {}
      agent.get(tournament.leaderboard_url) do |page|
        tbody = page.search("table.sportsTable tbody")
        rows = tbody.search("tr")
        rows.each do |row|
          score = {}
          name = row.search('.player').text.strip
          total_score_str = row.search(".total").text.strip
          actual_score = 0
          actual_score = total_score_str.to_i unless total_score_str == '-' || total_score_str == 'E'

          scores[name] = actual_score

        end

      end
      scores
    end
end
