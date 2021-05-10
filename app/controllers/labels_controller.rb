# frozen_string_literal: true

class LabelsController < ApplicationController
  def index
    @labels = Label.all
  end

  def edit
    @label = Label.find(params[:id])
  end

  def update
    @label = Label.find(params[:id])
    if @label.update(label_params)
      redirect_to labels_path
    else
      render :edit
    end
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end
end
