# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Status, type: :model do
  let(:status) { build(:status, name: name) }

  describe 'name' do
    context '正常な値の場合' do
      let(:name) { 'status_name' }

      it 'エラーにならない' do
        expect(status).to be_valid
      end
    end

    context 'nil の場合' do
      let(:name) { nil }

      before do
        status.valid?
      end

      it 'エラーになる' do
        expect(status.errors[:name]).to include(I18n.t('errors.messages.blank'))
      end
    end

    context '登録済みの場合' do
      let(:persisted_status) { create(:status) }
      let(:name) { persisted_status.name }

      before do
        status.valid?
      end

      it 'エラーになる' do
        expect(status.errors[:name]).to include(I18n.t('errors.messages.taken'))
      end
    end

    context '256 文字以上の場合' do
      let(:name) { 'a' * 256 }

      before do
        status.valid?
      end

      it 'エラーになる' do
        expect(status.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 255))
      end
    end
  end
end
