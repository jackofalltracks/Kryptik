class UsersController < Clearance::UsersController
  skip_before_filter :authorize, :only => [:create, :new]
  before_filter :avoid_sign_in, :only => [:create, :new], :if => :signed_in?

 def edit
	@user = User.find_by_id(params[:id])
  @bands = @user.bands
	@sex = %w{ Male Female Transgender }
	render template: 'users/edit'
 end

 def update
	@user = User.find(params[:id])
    @bands = @user.bands
    role = Role.find(params[:user][:role_ids]) unless params[:user][:role_ids].nil?
    params[:user] = params[:user].except(:role_ids)
	if @user.update_password password_reset_params
		sign_in @user
		@user.update_attributes(params[:user])
    redirect_to edit_user_path, notice: 'User was successfully updated.'
	else
		flash_failure_after_update
		render template:'users/edit'
	end
 end

 def new
    @user = user_from_params
    @plan = params[:plan]
    render :template => 'users/new'
 end

 def create
    @user = user_from_params
    @plan = params[:plan]
    @user.add_role @plan  
    @user.save
    sign_in @user
    redirect_to "/users/#{ current_user.id }/edit", notice: 'User was successfully created!'
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to root_url, notice: 'User was successfully dropped. Boo, Hiss.'  }
      format.json { head :no_content }
    end
  end

  def password_reset_params
	if params.has_key? :user
  		ActiveSupport::Deprecation.warn %{Since locales functionality was added, accessing params[:user] is no longer supported.}
  		params[:user][:password]
	else
  		params[:password_reset][:password]
	end
  end

  def find_user_by_id_and_confirmation_token
    Clearance.configuration.user_model.
      find_by_id_and_confirmation_token params[:user_id], params[:token].to_s
  end

  def find_user_for_create
    Clearance.configuration.user_model.
      find_by_normalized_email params[:password][:email]
  end

  def find_user_for_edit
    find_user_by_id_and_confirmation_token
  end

  def find_user_for_update
    find_user_by_id_and_confirmation_token
  end

  def flash_failure_when_forbidden
    flash.now[:notice] = translate(:forbidden,
      :scope => [:clearance, :controllers, :passwords],
      :default => t('flashes.failure_when_forbidden'))
  end

  def flash_failure_after_update
    flash.now[:notice] = translate(:blank_password,
      :scope => [:clearance, :controllers, :passwords],
      :default => t('flashes.failure_after_update'))
  end

  def forbid_missing_token
    if params[:token].to_s.blank?
      flash_failure_when_forbidden
      render :template => 'passwords/new'
    end
  end

  def forbid_non_existent_user
    unless find_user_by_id_and_confirmation_token
      flash_failure_when_forbidden
      render :template => 'passwords/new'
    end
  end

  def url_after_create
    '/users/#{current_user.id}/edit'
  end

  def url_after_update
    Clearance.configuration.redirect_url
  end

end

    