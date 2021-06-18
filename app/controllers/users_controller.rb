# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show]

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
    else
      flash.now[:alert] = t('.alert')
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: t('.notice')
  end

  def show
    @tasks = @user&.tasks
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
