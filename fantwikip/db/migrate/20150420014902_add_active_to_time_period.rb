class AddActiveToTimePeriod < ActiveRecord::Migration
  def change
  	add_column :time_periods, :active, :boolean, default: false
  end
end
