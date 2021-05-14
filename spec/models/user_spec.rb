# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'pass' do
    expect(build(:user)).to be_valid
  end

  it 'fail no name' do
    user = build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include(I18n.t('errors.messages.blank'))
  end

  it 'fail name already taken ' do
    first_user = create(:user)
    second_user = build(:user, name: first_user.name)
    second_user.valid?
    expect(second_user.errors[:name]).to include(I18n.t('errors.messages.taken'))
  end

  it 'fail name too long' do
    user = build(:user, name: SecureRandom.alphanumeric(256))
    user.valid?
    expect(user.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 255))
  end
end
