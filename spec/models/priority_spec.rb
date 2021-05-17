# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Priority, type: :model do
  let(:priority) { build(:priority, name: name, priority: priority_value) }

  describe 'name, priority' do
    context '正常系' do
      let(:name) { 'priority_name' }
      let(:priority_value) { 1 }

      it 'エラーにならない' do
        expect(priority).to be_valid
      end
    end
  end

  describe 'name' do
    let(:priority_value) { 1 }

    context 'nilの場合' do
      let(:name) { nil }

      before do
        priority.valid?
      end

      it 'エラーになる' do
        expect(priority.errors[:name]).to include(I18n.t('errors.messages.blank'))
      end
    end

    context '登録済みの場合' do
      let!(:persisted_priority) { create(:priority) }
      let(:name) { persisted_priority.name }

      before do
        priority.valid?
      end

      it 'エラーになる' do
        expect(priority.errors[:name]).to include(I18n.t('errors.messages.taken'))
      end
    end

    context '256 文字以上の場合' do
      let(:name) { 'a' * 256 }

      before do
        priority.valid?
      end

      it 'エラーになる' do
        expect(priority.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 255))
      end
    end
  end

  describe 'priority' do
    let(:name) { 'priority_name' }

    context 'nil の場合' do
      let(:priority_value) { nil }

      before do
        priority.valid?
      end

      it 'エラーになる' do
        expect(priority.errors[:priority]).to include(I18n.t('errors.messages.blank'))
      end
    end

    context '数値でない場合' do
      let(:priority_value) { 'hoge' }

      before do
        priority.valid?
      end

      it 'エラーになる' do
        expect(priority.errors[:priority]).to include(I18n.t('errors.messages.not_a_number'))
      end
    end

    context '登録済みの場合' do
      let!(:persisted_priority) { create(:priority) }
      let(:priority_value) { persisted_priority.priority }

      before do
        priority.valid?
      end

      it 'エラーになる' do
        expect(priority.errors[:priority]).to include(I18n.t('errors.messages.taken'))
      end
    end
  end
end
