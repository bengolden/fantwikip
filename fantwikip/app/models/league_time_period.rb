# == Schema Information
#
# Table name: league_time_periods
#
#  id             :integer          not null, primary key
#  league_id      :integer
#  time_period_id :integer
#  scoring_weight :float            default(1.0)
#  created_at     :datetime
#  updated_at     :datetime
#

class LeagueTimePeriod < ActiveRecord::Base
	belongs_to :league
	belongs_to :time_period

end