# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Priority, type: :model do
  it 'pass' do
    expect(build(:priority)).to be_valid
  end

  it 'fail no name' do
    priority = build(:priority, name: nil)
    priority.valid?
    expect(priority.errors[:name]).to include(I18n.t('errors.messages.blank'))
  end

  it 'fail name already taken ' do
    first_priority = create(:priority)
    second_priority = build(:priority, name: first_priority.name)
    second_priority.valid?
    expect(second_priority.errors[:name]).to include(I18n.t('errors.messages.taken'))
  end

  it 'fail name too long' do
    priority = build(:priority, name: SecureRandom.alphanumeric(256))
    priority.valid?
    expect(priority.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 255))
  end

  it 'fail no priority' do
    priority = build(:priority, priority: nil)
    priority.valid?
    expect(priority.errors[:priority]).to include(I18n.t('errors.messages.blank'))
  end

  it 'fail priority not a number' do
    priority = build(:priority, priority: 'hoge')
    priority.valid?
    expect(priority.errors[:priority]).to include(I18n.t('errors.messages.not_a_number'))
  end

  it 'fail priority already taken ' do
    first_priority = create(:priority)
    second_priority = build(:priority, priority: first_priority.priority)
    second_priority.valid?
    expect(second_priority.errors[:priority]).to include(I18n.t('errors.messages.taken'))
  end
end
