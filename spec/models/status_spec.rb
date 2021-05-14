# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Status, type: :model do
  it 'pass' do
    expect(build(:status)).to be_valid
  end

  it 'fail no name' do
    status = build(:status, name: nil)
    status.valid?
    expect(status.errors[:name]).to include(I18n.t('errors.messages.blank'))
  end

  it 'fail name already taken ' do
    first_label = create(:label)
    second_label = build(:label, name: first_label.name)
    second_label.valid?
    expect(second_label.errors[:name]).to include(I18n.t('errors.messages.taken'))
  end

  it 'fail name too long' do
    label = build(:label, name: SecureRandom.alphanumeric(256))
    label.valid?
    expect(label.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 255))
  end
end
