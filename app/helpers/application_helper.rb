module ApplicationHelper

	def current_band
    	Band.find(params[:id])
  	end

  	def profile_name_default
	    if User.last == nil || User.count == 0
	      return 1
	    else
	      User.last.id.to_i + 1  
		end  
  	end

end
