# frozen_string_literal: true

class LabelsController < ApplicationController
  before_action :label, only: %i[edit]

  def index
    @labels = Label.all
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to labels_path, notice: t('.notice')
    else
      flash.now[:alert] = t('.alert')
      render :new
    end
  end

  def edit; end

  def update
    if label.update(label_params)
      redirect_to labels_path, notice: t('.notice')
    else
      flash.now[:alert] = t('.alert')
      render :edit
    end
  end

  private

  def label
    @label ||= Label.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:name)
  end
end
