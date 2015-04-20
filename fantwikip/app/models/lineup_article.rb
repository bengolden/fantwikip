# == Schema Information
#
# Table name: lineup_articles
#
#  id              :integer          not null, primary key
#  lineup_id       :integer
#  article_id      :integer
#  last_year_views :integer
#  views           :integer
#  days_passed     :integer
#  points          :float
#  created_at      :datetime
#  updated_at      :datetime
#

class LineupArticle < ActiveRecord::Base
	belongs_to :lineup
	belongs_to :article
end
