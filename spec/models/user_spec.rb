# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it 'name が正常値なら有効' do
    expect(user).to be_valid
  end

  it 'name が無いなら無効' do
    user.name = nil
    user.valid?
    expect(user.errors[:name]).to include(I18n.t('errors.messages.blank'))
  end

  it 'name が既にあるなら無効' do
    first_user = create(:user)
    user.name = first_user.name
    user.valid?
    expect(user.errors[:name]).to include(I18n.t('errors.messages.taken'))
  end

  it 'name が256文字以上なら無効' do
    user.name = SecureRandom.alphanumeric(256)
    user.valid?
    expect(user.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 255))
  end
end
