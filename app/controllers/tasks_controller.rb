class TasksController < ApplicationController
  before_action :set_user
  
  
  # c5 indexアクション（一覧表示）
  def index
    @tasks = @user.tasks
  end
  
  def new
    @task = Task.new
  end 
  
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @user
    else
      render :new
    end 
    
    # 補足　buildによるtaskの保存方法※今はnewで代用可能らしい
    # @task = @user.tasks.build(task_params)
  end 
  
  
  # 以下、繰り返し利用するメソッドを記述する
  # before_actionを活用してコードと処理を簡潔にする。
  private
  
    def set_user
      @user = User.find(params[:user_id])
    end 
    
    def task_params
      params.require(:task).premit(:title, :detail,)
    end 
end
