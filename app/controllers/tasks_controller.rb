class TasksController < ApplicationController
  
  # c5 indexアクション（一覧表示）
  def index
    @user = User.find(params[:user_id])
    @tasks = @user.tasks
  end 
end
