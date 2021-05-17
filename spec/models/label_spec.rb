# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Label, type: :model do
  let(:label) { build(:label) }

  describe 'name' do
    context '正常系' do
      it 'エラーにならない' do
        expect(label).to be_valid
      end
    end

    context 'nil の場合' do
      it 'エラーになる' do
        label.name = nil
        label.valid?
        expect(label.errors[:name]).to include(I18n.t('errors.messages.blank'))
      end
    end

    context '登録済みの場合' do
      it 'エラーになる' do
        first_label = create(:label)
        label.name = first_label.name
        label.valid?
        expect(label.errors[:name]).to include(I18n.t('errors.messages.taken'))
      end
    end

    context '256 文字以上の場合' do
      it 'エラーになる' do
        label.name = SecureRandom.alphanumeric(256)
        label.valid?
        expect(label.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 255))
      end
    end
  end
end
