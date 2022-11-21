class AdminsController < ApplicationController
  skip_before_action :admin_auth_check, only: [:new, :create]
  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.create(params.require(:user).permit(:username, :password))
  end
end
