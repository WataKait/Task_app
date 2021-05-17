# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'name' do
    context '正常系' do
      it 'エラーにならない' do
        expect(user).to be_valid
      end
    end

    context 'nil の場合' do
      it 'エラーになる' do
        user.name = nil
        user.valid?
        expect(user.errors[:name]).to include(I18n.t('errors.messages.blank'))
      end
    end

    context '登録済みの場合' do
      it 'エラーになる' do
        first_user = create(:user)
        user.name = first_user.name
        user.valid?
        expect(user.errors[:name]).to include(I18n.t('errors.messages.taken'))
      end
    end

    context '256 文字以上の場合' do
      it 'エラーになる' do
        user.name = SecureRandom.alphanumeric(256)
        user.valid?
        expect(user.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 255))
      end
    end
  end
end
