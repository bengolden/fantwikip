class CreateLineups < ActiveRecord::Migration
  def change
    create_table :lineups do |t|
			t.integer :time_period_id
			t.integer :team_id

      t.timestamps
    end
  end
end
