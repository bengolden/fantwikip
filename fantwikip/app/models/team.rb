# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  owner_id   :string(255)
#  league_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Team < ActiveRecord::Base
  has_many :articles
  has_many :lineups
  belongs_to :league
  belongs_to :owner, class_name: "User"

  def points
  	self.lineups.map(&:points).inject(:+)
  end
end
