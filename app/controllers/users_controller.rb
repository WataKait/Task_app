# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :access_authentication
  before_action :set_user, only: %i[edit update destroy show]

  def index
    @users = User.all.preload(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: t('.notice')
    else
      flash.now[:alert] = t('.alert')
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: t('.notice')
    elsif @user.errors[:admin].present?
      flash.now[:alert] = t('.alert')
      flash.now[:warning] = t('.warning')
      render :edit
    else
      flash.now[:alert] = t('.alert')
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_path, notice: t('.notice')
    else
      redirect_to users_path, alert: t('.alert')
    end
  end

  def show
    @tasks = @user.tasks.eager_load(:label, :priority, :status)
  end

  private

  def access_authentication
    raise Forbidden unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :admin)
  end
end
