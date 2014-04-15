class AddParToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :par, :integer
  end
end
