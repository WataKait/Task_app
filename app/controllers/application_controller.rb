# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :logged_in_user

  helper_method :current_user

  private

  def current_user
    User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in_user
    redirect_to login_path if current_user.nil?
  end
end
