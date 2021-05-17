# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Priority, type: :model do
  let(:priority) { build(:priority) }

  it 'name と priority が正常値なら有効' do
    expect(priority).to be_valid
  end

  it 'name が無いなら無効' do
    priority.name = nil
    priority.valid?
    expect(priority.errors[:name]).to include(I18n.t('errors.messages.blank'))
  end

  it 'name が既にあるなら無効' do
    first_priority = create(:priority)
    priority.name = first_priority.name
    priority.valid?
    expect(priority.errors[:name]).to include(I18n.t('errors.messages.taken'))
  end

  it 'name が256文字以上なら無効' do
    priority.name = SecureRandom.alphanumeric(256)
    priority.valid?
    expect(priority.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 255))
  end

  it 'priority が無いなら無効' do
    priority.priority = nil
    priority.valid?
    expect(priority.errors[:priority]).to include(I18n.t('errors.messages.blank'))
  end

  it 'priority が数値でないなら無効' do
    priority.priority = 'hoge'
    priority.valid?
    expect(priority.errors[:priority]).to include(I18n.t('errors.messages.not_a_number'))
  end

  it 'priority が既にあるなら無効' do
    first_priority = create(:priority)
    priority.priority = first_priority.priority
    priority.valid?
    expect(priority.errors[:priority]).to include(I18n.t('errors.messages.taken'))
  end
end
