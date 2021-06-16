# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all.preload(:tasks)
  end
end
