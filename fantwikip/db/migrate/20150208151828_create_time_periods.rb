class CreateTimePeriods < ActiveRecord::Migration
  def change
    create_table :time_periods do |t|
			t.string :name
			t.string :duration
			t.date :start_date
			t.date :end_date
      t.timestamps
    end
  end
end
