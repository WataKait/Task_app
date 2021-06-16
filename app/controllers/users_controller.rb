# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all.preload(:tasks)
  end

  def destroy
    @user=User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: t('.notice')
  end
end
