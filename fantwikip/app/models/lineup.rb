# == Schema Information
#
# Table name: lineups
#
#  id             :integer          not null, primary key
#  time_period_id :integer
#  team_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Lineup < ActiveRecord::Base
  belongs_to :team
  belongs_to :time_period
  has_many :lineup_articles

  def points
  	self.lineup_articles.pluck(:points).inject(:+)
  end

  def active?
  	self.time_period.active?
  end

  def expired?
  	self.time_period.expired?
  end
end
