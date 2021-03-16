class TasksController < ApplicationController
  before_action :set_user
  
  
  # c5 indexアクション（一覧ページ）
  def index
    @tasks = @user.tasks
    # ↑@userは「current_user」でも代用可能。（session_helper.rb　でcurrent_user を定義しているため）
  end
  
  #c6 newアクション（新規作成ページ）
  def new
    @task = Task.new
  end 
  
  # C6 newアクションで入力した情報を保存するアクション（viewなし）
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
  
  # c7 editアクション（更新ページ）
  def edit
    @task = @user.tasks.find(params[:id])
  end

  # c7 editアクションで入力した更新情報を保存するアクション（viewなし）
  def update
    @task = @user.tasks.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "タスク情報を更新しました。"
      redirect_to user_tasks_url @user
    else
      flash.now[:danger] = "更新に失敗しました。"
      render :edit
    end
  end 
  

  
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
