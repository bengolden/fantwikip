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

  def update_lineup_article_views
    self.lineup_articles.each do |lineup_article|
      lineup_article.update_views
    end
  end


  def points
  	self.lineup_articles.pluck(:points).inject(:+)
  end

  def active?
  	self.time_period.active?
  end

  def expired?
  	self.time_period.expired?
  end

  def time_period_duration
    self.time_period.duration
  end

  def year
    self.time_period.start_date.year
  end

  def month
    self.time_period.start_date.month if time_period_duration == "month"
  end

end
