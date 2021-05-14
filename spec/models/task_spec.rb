# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'name が正常値なら有効' do
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
end
