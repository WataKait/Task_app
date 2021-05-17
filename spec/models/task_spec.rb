# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { build(:task) }

  describe 'name, user, priority, status' do
    context '正常系' do
      it 'エラーにならない' do
        expect(task).to be_valid
      end
    end
  end

  describe 'name' do
    context 'nil の場合' do
      it 'エラーになる' do
        task.name = nil
        task.valid?
        expect(task.errors[:name]).to include(I18n.t('errors.messages.blank'))
      end
    end

    context '256 文字以上の場合' do
      it 'エラーになる' do
        task.name = SecureRandom.alphanumeric(256)
        task.valid?
        expect(task.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 255))
      end
    end
  end

  describe 'user' do
    context 'nil の場合' do
      it 'エラーになる' do
        task.user = nil
        task.valid?
        expect(task.errors[:user]).to include(I18n.t('errors.messages.required'))
      end
    end
  end

  describe 'priority' do
    context 'nil の場合' do
      it 'エラーになる' do
        task.priority = nil
        task.valid?
        expect(task.errors[:priority]).to include(I18n.t('errors.messages.required'))
      end
    end
  end

  describe 'status' do
    context 'nil の場合' do
      it 'エラーになる' do
        task.status = nil
        task.valid?
        expect(task.errors[:status]).to include(I18n.t('errors.messages.required'))
      end
    end
  end
end
