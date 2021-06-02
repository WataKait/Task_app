# frozen_string_literal: true

class TasksController < ApplicationController
  DEFAULT_SORT_COLUMN = :created_at

  SORTABLE_COLUMN = {
    created_at: :created_at,
    time_limit: :time_limit,
    "priorities.priority": :"priorities.priority",
  }.freeze

  before_action :set_task, only: %i[show edit update destroy]
  before_action :set_labels, only: %i[new create edit update]
  before_action :set_priorities, only: %i[new create edit update]
  before_action :set_statuses, only: %i[new create edit update]
  helper_method :current_sort_order, :current_sort_column

  def index
    # TODO: ログイン機能実装後、user_idを取得してくる
    user_id = 1
    @tasks = Task.joins(:priority).where(user_id: user_id).order("#{current_sort_column} desc")
    @tasks = @tasks.reverse_order if params[:direction] == 'asc'
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: t('.notice')
    else
      flash.now[:alert] = t('.alert')
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('.notice')
    else
      flash.now[:alert] = t('.alert')
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('.notice')
  end

  def search
    # TODO: ログイン機能実装後、user_idを取得してくる
    user_id = 1
    status_ids = search_statuses(params[:search]).ids
    @tasks = search_tasks(params[:search], status_ids, user_id).order("#{current_sort_column} desc")
    render :index
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

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

  def current_sort_order
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def current_sort_column
    SORTABLE_COLUMN[params[:sort]&.to_sym] || DEFAULT_SORT_COLUMN
  end

  def search_statuses(keyword)
    if keyword.present?
      Status.where('name LIKE ?', "%#{keyword}%")
    else
      Status.all
    end
  end

  def search_tasks(keyword, status_ids, user_id)
    if keyword.present?
      tasks = User.find(user_id).tasks
      tasks.where('name LIKE ?', "%#{keyword}%").or(tasks.where(status_id: status_ids))
    else
      Task.where('user_id = ?', user_id)
    end
  end
end
