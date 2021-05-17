# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Label, type: :model do
  let(:label) { build(:label) }

  it 'name が正常値なら有効' do
    expect(label).to be_valid
  end

  it 'name が無いなら無効' do
    label.name = nil
    label.valid?
    expect(label.errors[:name]).to include(I18n.t('errors.messages.blank'))
  end

  it 'name が既にあるなら無効' do
    first_label = create(:label)
    label.name = first_label.name
    label.valid?
    expect(label.errors[:name]).to include(I18n.t('errors.messages.taken'))
  end

  it 'name が256文字以上なら無効' do
    label.name = SecureRandom.alphanumeric(256)
    label.valid?
    expect(label.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 255))
  end
end
