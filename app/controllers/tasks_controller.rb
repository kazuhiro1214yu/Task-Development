class TasksController < ApplicationController
  before_action :set_user
  
  
  # c5 indexアクション（一覧表示）
  def index
    @tasks = @user.tasks
    # ↑@userは「current_user」でも代用可能。（session_helper.rb　でcurrent_user を定義しているため）
  end
  
  def new
    @task = Task.new
  end 
  
  def create
    @task = @user.tasks.build(task_params)
    # ↑@userは「current_user」でも代用可能。（session_helper.rb　でcurrent_user を定義しているため）
    if @task.save
      flash[:success] = "タスク新規登録しました"
      redirect_to user_tasks_url @user
    else
      flash.now[:danger] = "タスク新規登録失敗しました"
      render :new
    end 
    # 補足　buildによるtaskの保存方法※今はnewで代用可能らしい
    # @task = @user.tasks.build(task_params)
  end 
# ★保存失敗した場合、直前に入力した内容が全て消える。直前の入力内容を残すコードが記述できていない★
  
  
  # 以下、繰り返し利用するメソッドを記述する
  # before_actionを活用してコードと処理を簡潔にする。
  private
  
    def set_user
      @user = User.find(params[:user_id])
    end 
    
    def task_params
      params.require(:task).permit(:title, :detail,)
    end 
end
