# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    user_id = 1 # ログイン機能実装後、ログインIDを user_id に格納

    @tasks = Task.where(user_id: user_id)
  end

  def dummy_action_hoge
    puts 'this action is dummy'
  end

  def show
    @task = Task.where(user_id: user_id).first
  end
end
