class SessionsController < ApplicationController
  # #ログイン済みの場合、ログイン画面を表示させないためのメソッド
  #   before_action :limitation_login_user, only: [:new]
  
  def new
    if logged_in?
      flash[:notice] = "ログイン済みです"
      redirect_to @current_user
    end 
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = "ログインしました。"
      redirect_to user
    else
      flash.now[:danger] = '認証に失敗しました。'
      render :new
    end
  end
  
  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
end
