# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_priority, only: %i[new]
  before_action :set_status, only: %i[new]

  def index
    user_id = 1 # ログイン機能実装後、ログインIDを user_id に格納

    @tasks = Task.where(user_id: user_id)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
    @label = Label.new
  end

  def create
    task = Task.new(task_params)
    task.labels.build(label_params)
    task.save
    redirect_to tasks_path
  end

  private

  def task_params
    params[:task].permit(:user_id, :name, :comparison_val, :priority_id, :time_limit, :status_id, :description)
  end

  def label_params
    params[:label].permit(:label)
  end

  def set_priority
    @priority = Priority.all
  end

  def set_status
    @status = Status.all
  end
end
