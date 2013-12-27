class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.datetime :picks_start
      t.datetime :picks_end
      t.references :admin
      t.timestamps
    end
  end
end
