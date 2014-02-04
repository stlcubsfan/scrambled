class AddSecretCodeToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :secret_code, :string
  end
end
