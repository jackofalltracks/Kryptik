class UsersController < Clearance::UsersController

	def edit
		@user = User.find_by_id(params[:id])
    	render template: 'users/edit'
  	end

	def update
    	@user = User.find(params[:id])
    	respond_to do |format|
      		if @user.update_attributes(params[:user])
        		format.html { redirect_to "/", :status => 301, notice: 'User was successfully updated.' }
        		format.json { head :no_content }
      		else
        		format.html { render action: "edit" }
        		format.json { render json: @user.errors, status: :unprocessable_entity }
      		end
    	end
  	end


end	