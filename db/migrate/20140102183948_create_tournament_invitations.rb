class CreateTournamentInvitations < ActiveRecord::Migration
  def change
    create_table :tournament_invitations do |t|
      t.string :invite_code, null: false, index: true
      t.boolean :accepted, default: false
      t.references :user, index: true
      t.references :tournament, index: true

      t.timestamps
    end
  end
end
