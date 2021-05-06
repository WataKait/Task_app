# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_labels, only: %i[new create edit update]
  before_action :set_priorities, only: %i[new create edit update]
  before_action :set_statuses, only: %i[new create edit update]

  def index
    # TODO: ログイン機能実装後、user_idを取得してくる
    user_id = 1
    @tasks = Task.where(user_id: user_id)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: 'タスクを作成しました'
    else
      flash.now[:alert] = 'タスクを作成できませんでした'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'タスクを更新しました'
    else
      flash.now[:alert] = 'タスクを更新できませんでした'
      render :edit
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :user_id, :label_id, :priority_id, :status_id, :time_limit, :description)
  end

  def set_labels
    @labels = Label.all
  end

  def set_priorities
    @priorities = Priority.all
  end

  def set_statuses
    @statuses = Status.all
  end
end
