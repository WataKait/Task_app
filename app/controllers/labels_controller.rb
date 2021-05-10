# frozen_string_literal: true

class LabelsController < ApplicationController
  def index
    @labels = Label.all
  end

  def destroy
    label = Label.find(params[:id])
    label.destroy
    redirect_to labels_path, notice: t('.notice')
  end
end
