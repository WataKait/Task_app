# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    user_id = 1 # ログイン機能実装後、ログインIDを user_id に格納

    @tasks = Task.where(user_id: user_id)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
    @status = Status.all
    @task.build_status
    @task.build_priority
  end
end
