class LeaguesController < ApplicationController

	def show
		@league = League.find(params[:id])
	end

end
