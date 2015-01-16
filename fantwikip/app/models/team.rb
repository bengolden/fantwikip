class Team < ActiveRecord::Base
  has_many :articles
  has_many :lineups
end
