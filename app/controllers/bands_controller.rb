class BandsController < ApplicationController
  # GET /bands
  # GET /bands.json
  def index
    @bands = Band.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bands }
    end
  end

  # GET /bands/1
  # GET /bands/1.json
  def show
    @band = Band.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @band }
    end
  end

  # GET /bands/new
  # GET /bands/new.json
  def new
    @band = Band.new
    # @band.members.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @band }
    end
  end

  # GET /bands/1/edit
  def edit
    @band = Band.find(params[:id])
  end

  # POST /bands
  # POST /bands.json
  def create
    @band = Band.new(params[:band])
    # @band.members.build
    # @band.save
    @user = current_user
    # @user.bands << @band # unless @user.bands.last.members.includes?(@user)
    respond_to do |format|
      if @band.save
        @user.bands << Band.last
        format.html { redirect_to edit_user_path(current_user.id), notice: "#{Band.last.name} was created & you are a Member!" }
        format.json { render json: @band, status: :created, location: @band }
      else
        format.html { render action: "new" }
        format.json { render json: @band.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bands/1
  # PUT /bands/1.json
  def update
    @band = Band.find(params[:id])

    respond_to do |format|
      if @band.update_attributes(params[:band])
        format.html { redirect_to edit_user_path(current_user.id), notice: 'Band was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @band.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bands/1
  # DELETE /bands/1.json
  def destroy
    @band = Band.find(params[:id])
    @band.destroy

    respond_to do |format|
      format.html { redirect_to edit_user_path(current_user.id), notice: 'Band was successfully dropped.'  }
      format.json { head :no_content }
    end
  end
end
