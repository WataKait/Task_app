# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  has_secure_password validations: false
  validates :password, presence: true, length: { minimum: 8, maximum: 255 }, confirmation: true, on: :create
  validates :password, presence: true, length: { minimum: 8, maximum: 255 }, confirmation: true, if: :password_was_entered?, on: :update
  before_destroy :administrator_must_exist

  private

  def administrator_must_exist
    selected_user = self
    return unless User.where(admin: true).size == 1 && selected_user.admin?

    throw :abort
  end

  def password_was_entered?
    password.present? || password_confirmation.present?
  end
end
