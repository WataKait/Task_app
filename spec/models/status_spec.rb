# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Status, type: :model do
  let(:status) { build(:status) }

  it 'name が正常値なら有効' do
    expect(status).to be_valid
  end

  it 'name が無いなら無効' do
    status.name = nil
    status.valid?
    expect(status.errors[:name]).to include(I18n.t('errors.messages.blank'))
  end

  it 'name が既にあるなら無効' do
    first_status = create(:status)
    status.name = first_status.name
    status.valid?
    expect(status.errors[:name]).to include(I18n.t('errors.messages.taken'))
  end

  it 'name が256文字以上なら無効' do
    status.name = SecureRandom.alphanumeric(256)
    status.valid?
    expect(status.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 255))
  end
end
