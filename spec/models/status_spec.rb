# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Status, type: :model do
  let(:status) { build(:status) }

  describe 'name' do
    context '正常系' do
      it 'エラーにならない' do
        expect(status).to be_valid
      end
    end

    context 'nil の場合' do
      it 'エラーになる' do
        status.name = nil
        status.valid?
        expect(status.errors[:name]).to include(I18n.t('errors.messages.blank'))
      end
    end

    context '登録済みの場合' do
      it 'エラーになる' do
        first_status = create(:status)
        status.name = first_status.name
        status.valid?
        expect(status.errors[:name]).to include(I18n.t('errors.messages.taken'))
      end
    end

    context '256 文字以上の場合' do
      it 'エラーになる' do
        status.name = SecureRandom.alphanumeric(256)
        status.valid?
        expect(status.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 255))
      end
    end
  end
end
