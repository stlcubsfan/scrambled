class AddMessageToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :message, :string
  end
end
