# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_logged_in

  def new; end

  def create
    user = User.find_by(name: params[:name])
    if user&.authenticate(params[:password])
      log_in(user)
      redirect_to tasks_path
    else
      flash.now[:alert] = t('.alert')
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end

  private

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
  end
end
