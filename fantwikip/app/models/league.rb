# == Schema Information
#
# Table name: leagues
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class League < ActiveRecord::Base
	has_many :league_time_periods, dependent: :destroy
	has_many :teams, dependent: :destroy
	has_many :lineups, through: :teams
	has_many :lineup_articles, through: :lineups
end
