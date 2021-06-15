# frozen_string_literal: true

class TasksController < ApplicationController
  DEFAULT_SORT_COLUMN = :'tasks.created_at'

  SORTABLE_COLUMN = {
    time_limit: :time_limit,
    priority: :'priorities.priority',
  }.freeze

  RECORDS_NUMBER_TO_DISPLAY = 10

  before_action :logged_in_user
  before_action :set_task, only: %i[show edit update destroy]
  before_action :set_labels, only: %i[new create edit update]
  before_action :set_priorities, only: %i[new create edit update]
  before_action :set_statuses, only: %i[new create edit update]
  helper_method :current_sort_order, :current_sort_column

  def index
    @tasks = current_user.tasks.eager_load(:label, :priority, :status).order("#{database_sort_column} desc")
    @tasks = @tasks.reverse_order if params[:direction] == 'asc'
    @tasks = @tasks.page(params[:page]).per(RECORDS_NUMBER_TO_DISPLAY)
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
    status_ids = search_statuses(params[:search]).ids
    @tasks = search_tasks(params[:search], status_ids).eager_load(:label, :priority, :status).order("#{database_sort_column} desc")
    @tasks = @tasks.reverse_order if params[:direction] == 'asc'
    @tasks = @tasks.page(params[:page]).per(RECORDS_NUMBER_TO_DISPLAY)
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
    params[:sort]&.to_sym || DEFAULT_SORT_COLUMN
  end

  def database_sort_column
    SORTABLE_COLUMN[params[:sort]&.to_sym] || DEFAULT_SORT_COLUMN
  end

  def logged_in_user
    redirect_to login_path unless logged_in?
  end

  def search_statuses(keyword)
    if keyword.present?
      Status.where('name LIKE ?', "%#{keyword}%")
    else
      Status.all
    end
  end

  def search_tasks(keyword, status_ids)
    if keyword.present?
      tasks = current_user.tasks
      tasks.where('tasks.name LIKE ?', "%#{keyword}%").or(tasks.where(status_id: status_ids))
    else
      current_user.tasks
    end
  end
end
