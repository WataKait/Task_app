# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :logged_in_user

  def logged_in_user
    redirect_to login_path unless logged_in?
  end
end
