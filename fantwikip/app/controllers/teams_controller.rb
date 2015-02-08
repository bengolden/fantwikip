class TeamsController < ApplicationController

	def show
		@team = Team.find(params[:id])
		@league = @team.league
	end

end
