class MembersController < ApplicationController
  # def index
  #   @band = Band.find(params[:band_id])
  #   @members = @band.users
  # end
  
  # def destroy
  #   @band = Band.find(params[:band_id]) 
  #   @member = @band.members.find_by_user_id(params[:id])
  #   @member.delete
  #   redirect_to band_members_path(@band)
  # end

  # def create
  #   @user = User.find(params[:user_id])
  #   @band = Band.find(params[:band_id])    
  #   @member = @band.members.create(params[:member])
  #   @user.bands << @band
  # end

end