# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user, name: name) }

  describe 'name' do
    context '正常系' do
      let(:name) { 'user_name' }

      it 'エラーにならない' do
        expect(user).to be_valid
      end
    end

    context 'nil の場合' do
      let(:name) { nil }

      before do
        user.valid?
      end

      it 'エラーになる' do
        expect(user.errors[:name]).to include(I18n.t('errors.messages.blank'))
      end
    end

    context '登録済みの場合' do
      let!(:persisted_user) { create(:user) }
      let(:name) { persisted_user.name }

      before do
        user.valid?
      end

      it 'エラーになる' do
        expect(user.errors[:name]).to include(I18n.t('errors.messages.taken'))
      end
    end

    context '256 文字以上の場合' do
      let(:name) { SecureRandom.alphanumeric(256) }

      before do
        user.valid?
      end

      it 'エラーになる' do
        expect(user.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 255))
      end
    end
  end
end
