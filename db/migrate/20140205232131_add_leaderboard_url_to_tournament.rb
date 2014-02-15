class AddLeaderboardUrlToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :leaderboard_url, :string
  end
end
