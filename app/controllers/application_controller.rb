# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :require_logged_in

  helper_method :current_user

  private

  def current_user
    User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_logged_in
    redirect_to login_path if current_user.nil?
  end
end
