# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  has_secure_password validations: false
  validates :password, presence: true, length: { minimum: 8, maximum: 255 }, confirmation: true, on: :create
  validates :password, presence: true, length: { minimum: 8, maximum: 255 }, confirmation: true, if: :password_was_entered?, on: :update
  before_destroy :administrator_must_exist
  validate :administrator_must_exist_at_update, on: :update

  private

  def administrator_must_exist
    selected_user = self
    return unless User.where(admin: true).size == 1 && selected_user.admin?

    throw :abort
  end

  def administrator_must_exist_at_update
    selected_user = User.find(id)
    parameter_admin = admin
    return unless User.where(admin: true).size == 1 && selected_user.admin? && parameter_admin == false

    errors.add(:admin, :required)
    false
  end

  def password_was_entered?
    password.present? || password_confirmation.present?
  end
end
