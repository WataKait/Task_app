# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { create(:user) }
  let(:priority) { create(:priority) }
  let(:status) { create(:status) }
  let(:task) { build(:task, name: name, user: user, priority: priority, status: status) }

  describe 'name, user, priority, status' do
    context '正常系' do
      let(:name) { 'task_name' }

      it 'エラーにならない' do
        expect(task).to be_valid
      end
    end
  end

  describe 'name' do
    context 'nil の場合' do
      let(:name) { nil }

      before do
        task.valid?
      end

      it 'エラーになる' do
        expect(task.errors[:name]).to include(I18n.t('errors.messages.blank'))
      end
    end

    context '256 文字以上の場合' do
      let(:name) { SecureRandom.alphanumeric(256) }

      before do
        task.valid?
      end

      it 'エラーになる' do
        expect(task.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 255))
      end
    end
  end

  describe 'user' do
    context 'nil の場合' do
      let(:name) { 'task_name' }
      let(:user) { nil }

      before do
        task.valid?
      end

      it 'エラーになる' do
        expect(task.errors[:user]).to include(I18n.t('errors.messages.required'))
      end
    end
  end

  describe 'priority' do
    context 'nil の場合' do
      let(:name) { 'task_name' }
      let(:priority) { nil }

      before do
        task.valid?
      end

      it 'エラーになる' do
        expect(task.errors[:priority]).to include(I18n.t('errors.messages.required'))
      end
    end
  end

  describe 'status' do
    context 'nil の場合' do
      let(:name) { 'task_name' }
      let(:status) { nil }

      before do
        task.valid?
      end

      it 'エラーになる' do
        expect(task.errors[:status]).to include(I18n.t('errors.messages.required'))
      end
    end
  end
end
