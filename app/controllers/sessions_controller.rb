class SessionsController < ApplicationController
  skip_before_action :admin_auth_check, only: [:new, :create, :welcome, :by_code]
  def new
  end

  def by_code
    redirect_to quiz_code_path(params[:code]) and return if Group.find_by(id: params[:code])
    redirect_to welcome_path, warning: 'Группа не найдена'
  end

  def create
    @admin = Admin.find_by(username: params[:username])
    if @admin&.authenticate(params[:password])
      session[:admin_id] = @admin.id
      redirect_to groups_path
    else
      redirect_to login_path, warning: 'Авторизация не пройдена'
    end
  end

  def login
  end

  def welcome
  end
end
