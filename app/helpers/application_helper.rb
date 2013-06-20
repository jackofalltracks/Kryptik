module ApplicationHelper

	def current_band
    	Band.find(params[:id])
  	end

end
