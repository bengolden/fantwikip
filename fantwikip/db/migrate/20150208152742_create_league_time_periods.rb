class CreateLeagueTimePeriods < ActiveRecord::Migration
  def change
    create_table :league_time_periods do |t|
    	t.integer :league_id
    	t.integer :time_period_id
    	t.float :scoring_weight, default: 1

      t.timestamps
    end
  end
end
