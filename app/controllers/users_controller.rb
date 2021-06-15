# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all.eager_load(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = Task.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

end
