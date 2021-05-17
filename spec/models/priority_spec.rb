# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Priority, type: :model do
  let(:priority) { build(:priority) }

  describe 'name, priority' do
    context '正常系' do
      it 'エラーにならない' do
        expect(priority).to be_valid
      end
    end
  end

  describe 'name' do
    context 'nilの場合' do
      it 'エラーになる' do
        priority.name = nil
        priority.valid?
        expect(priority.errors[:name]).to include(I18n.t('errors.messages.blank'))
      end
    end

    context '登録済みの場合' do
      it 'エラーになる' do
        first_priority = create(:priority)
        priority.name = first_priority.name
        priority.valid?
        expect(priority.errors[:name]).to include(I18n.t('errors.messages.taken'))
      end
    end

    context '256 文字以上の場合' do
      it 'エラーになる' do
        priority.name = SecureRandom.alphanumeric(256)
        priority.valid?
        expect(priority.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 255))
      end
    end
  end

  describe 'priority' do
    context 'nil の場合' do
      it 'エラーになる' do
        priority.priority = nil
        priority.valid?
        expect(priority.errors[:priority]).to include(I18n.t('errors.messages.blank'))
      end
    end

    context '数値でない場合' do
      it 'エラーになる' do
        priority.priority = 'hoge'
        priority.valid?
        expect(priority.errors[:priority]).to include(I18n.t('errors.messages.not_a_number'))
      end
    end

    context '登録済みの場合' do
      it 'エラーになる' do
        first_priority = create(:priority)
        priority.priority = first_priority.priority
        priority.valid?
        expect(priority.errors[:priority]).to include(I18n.t('errors.messages.taken'))
      end
    end
  end
end
