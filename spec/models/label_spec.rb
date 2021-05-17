# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Label, type: :model do
  let(:label) { build(:label, name: name) }

  describe 'name' do
    context '正常な値の場合' do
      let(:name) { 'label_name' }

      it 'エラーにならない' do
        expect(label).to be_valid
      end
    end

    context 'nil の場合' do
      let(:name) { nil }

      before do
        label.valid?
      end

      it 'エラーになる' do
        expect(label.errors[:name]).to include(I18n.t('errors.messages.blank'))
      end
    end

    context '登録済みの場合' do
      let!(:persisted_label) { create(:label) }
      let(:name) { persisted_label.name }

      before do
        label.valid?
      end

      it 'エラーになる' do
        expect(label.errors[:name]).to include(I18n.t('errors.messages.taken'))
      end
    end

    context '256 文字以上の場合' do
      let(:name) { 'a' * 256 }

      before do
        label.valid?
      end

      it 'エラーになる' do
        expect(label.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 255))
      end
    end
  end
end
