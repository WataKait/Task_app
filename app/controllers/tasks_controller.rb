# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    # TODO: ログイン機能実装後、user_idを取得してくる
    user_id = 1
    @tasks = Task.where(user_id: user_id)
  end
end
