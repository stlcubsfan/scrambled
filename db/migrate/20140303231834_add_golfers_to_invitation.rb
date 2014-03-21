class AddGolfersToInvitation < ActiveRecord::Migration
  def change
    add_column :tournament_invitations, :agolfer, :string
    add_column :tournament_invitations, :bgolfer, :string
    add_column :tournament_invitations, :cgolfer, :string
    add_column :tournament_invitations, :dgolfer, :string
  end
end
