# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Article < ActiveRecord::Base
  has_many :lineup_articles
  has_many :lineups, through: :lineup_articles
  has_many :teams, through: :lineups
end
