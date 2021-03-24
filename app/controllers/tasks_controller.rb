class TasksController < ApplicationController
  before_action :set_user
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :correct_user
  
  
  
  # c5 indexアクション（一覧ページ）
  def index
    @tasks = @user.tasks.order("id DESC")
    # ↑@userは「current_user」でも代用可能。（session_helper.rb　でcurrent_user を定義しているため）
    # id DESCは結果を「降順」で表示する引数です 
  end
  
  #c6 newアクション（新規作成ページ）
  def new
    @task = Task.new
  end 
  
  def show
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
  end

  # c7 editアクションで入力した更新情報を保存するアクション（viewなし）
  def update
    if @task.update_attributes(task_params)
      flash[:success] = "タスク情報を更新しました。"
      redirect_to user_tasks_url @user
    else
      flash.now[:danger] = "更新に失敗しました。"
      render :edit
    end
  end 
  
  def destroy
      @task.destroy
      flash[:success] = "タスク情報を削除しました。"
      redirect_to user_tasks_url @user
  end 

  
  # 以下、繰り返し利用するメソッドを記述する
  # before_actionを活用してコードと処理を簡潔にする。
  private
  
    def task_params
      params.require(:task).permit(:title, :detail,)
    end 
    
    def set_user
      @user = User.find(params[:user_id])
    end 
    
    def set_task
      unless @task = @user.tasks.find_by(id: params[:id])
        flash[:danger] = "権限がありません"
        redirect_to user_tasks_url @user
      end
    end 
end
