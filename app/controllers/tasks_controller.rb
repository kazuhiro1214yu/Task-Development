class TasksController < ApplicationController
  before_action :set_user
  
  
  # c5 indexアクション（一覧表示）
  def index
    @tasks = @user.tasks
  end
  
  def new
  end 
  
  
  # 以下、繰り返し利用するメソッドを記述する
  # before_actionを活用してコードと処理を簡潔にする。
  private
  
    def set_user
      @user = User.find(params[:user_id])
    end 
end
