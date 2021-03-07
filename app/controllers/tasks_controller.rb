class TasksController < ApplicationController
  
  # c5 indexアクション（一覧表示）
  def index
    @task = Task.find(1)
  end 
  
end
