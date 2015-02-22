require 'open-uri'

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

	def update_views
		if time_period_duration == "month"
			content = open(URI.encode("http://stats.grok.se/json/en/#{year}#{format_month(month)}/#{article_name}")).read
	    self.views = JSON.parse(content)["daily_views"].values.inject(:+)
	    self.days_passed = JSON.parse(content)["daily_views"].values.select{|v| v > 0}.count
	    self.save
	  end
	end

	def time_period_duration
		self.lineup.time_period_duration
	end

	def article_name
		self.article.name
	end

	def year
		self.lineup.year
	end

	def month
		self.lineup.month
	end

	def format_month(month)
		sprintf '%02d', month
	end

end
