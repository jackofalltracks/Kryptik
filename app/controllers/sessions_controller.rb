class SessionsController < Clearance::SessionsController
  # skip_before_filter :authorize, :only => [:create, :new, :destroy]
  protect_from_forgery :except => :create

  def create
    @user = authenticate(params)
    @plan = params[:plan]
    # @user.add_role @plan
    if @user.nil?
      flash_failure_after_create
      render :template => 'sessions/new', :status => :unauthorized
    else
      sign_in @user
      redirect_back_or url_after_create
    end
  end

  def destroy
    sign_out
    redirect_to url_after_destroy
  end

  def new
    @plan = params[:plan]
    if @plan
      render :template => 'sessions/new'
      super
    end
  end

  private

  def flash_failure_after_create
    flash.now[:notice] = translate(:bad_email_or_password,
      :scope => [:clearance, :controllers, :sessions],
      :default => t('flashes.failure_after_create', :sign_up_path => sign_up_path).html_safe)
  end

  def url_after_destroy
    sign_in_url
  end

  def url_after_create
    edit_user_path(current_user.id)
  end
  
end