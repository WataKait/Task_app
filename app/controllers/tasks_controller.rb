class TasksController < ApplicationController
  def index
    user_id = 1 #ログイン機能実装後、ログインIDを user_id に格納

    @tasks = Task.where(user_id: user_id)
  end

  def show
    @tasks = Task.find(params[:id])
  end
end
