class ApplicationController < ActionController::Base
  add_flash_types :warning, :success, :info, :danger

  before_action :admin_auth_check
  helper_method :current_admin
  helper_method :admin_logged_in?
  def current_admin
    Admin.find_by(id: session[:admin_id])
  end

  def admin_logged_in?
    !current_admin.nil?
  end

  def admin_auth_check
    redirect_to '/welcome' unless admin_logged_in?
  end

end
