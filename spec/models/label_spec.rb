# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Label, type: :model do
  it 'name が正常値なら有効' do
    expect(build(:label)).to be_valid
  end

  it 'name が無いなら無効' do
    label = build(:label, name: nil)
    label.valid?
    expect(label.errors[:name]).to include(I18n.t('errors.messages.blank'))
  end

  it 'name が既にあるなら無効' do
    first_label = create(:label)
    second_label = build(:label, name: first_label.name)
    second_label.valid?
    expect(second_label.errors[:name]).to include(I18n.t('errors.messages.taken'))
  end

  it 'name が256文字以上なら無効' do
    label = build(:label, name: SecureRandom.alphanumeric(256))
    label.valid?
    expect(label.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 255))
  end
end
