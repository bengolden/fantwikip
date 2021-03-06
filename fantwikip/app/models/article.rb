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
  belongs_to :team
  has_many :lineup_articles
end
