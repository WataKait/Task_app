# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'name, user, priority, status が正常値なら有効' do
    expect(build(:task)).to be_valid
  end

  it 'name が無いなら無効' do
    task = build(:task, name: nil)
    task.valid?
    expect(task.errors[:name]).to include(I18n.t('errors.messages.blank'))
  end

  it 'name が256文字以上なら無効' do
    task = build(:task, name: SecureRandom.alphanumeric(256))
    task.valid?
    expect(task.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 255))
  end

  it 'user が無いなら無効' do
    task = build(:task, user: nil)
    task.valid?
    expect(task.errors[:user]).to include(I18n.t('errors.messages.required'))
  end

  it 'priority が無いなら無効' do
    task = build(:task, priority: nil)
    task.valid?
    expect(task.errors[:priority]).to include(I18n.t('errors.messages.required'))
  end

  it 'status が無いなら無効' do
    task = build(:task, status: nil)
    task.valid?
    expect(task.errors[:status]).to include(I18n.t('errors.messages.required'))
  end
end
