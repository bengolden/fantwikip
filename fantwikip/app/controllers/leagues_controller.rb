class LeaguesController < ApplicationController

	def show
		@league = League.find(params[:id])
	end

	def update
		@league = League.find(params[:id])
		if @league.last_updated_at.to_date < Time.now.to_date
			@league.update_article_counts
		end
	end

	def index
		@leagues = League.all
	end

	def new
		@league = League.new
	end

end
