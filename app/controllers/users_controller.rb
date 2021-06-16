# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all.eager_load(:tasks)
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: t('.notice')
    else
      flash.now[:alert] = t('.alert')
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
