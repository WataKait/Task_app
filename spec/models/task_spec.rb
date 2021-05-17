# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { build(:task, name: name, user: task_user, priority: task_priority, status: task_status) }
  let(:user) { create(:user) }
  let(:priority) { create(:priority) }
  let(:status) { create(:status) }

  describe 'name, user, priority, status' do
    context '正常系' do
      let(:name) { 'task_name' }
      let(:task_user) { user }
      let(:task_priority) { priority }
      let(:task_status) { status }

      it 'エラーにならない' do
        expect(task).to be_valid
      end
    end
  end

  describe 'name' do
    let(:task_user) { user }
    let(:task_priority) { priority }
    let(:task_status) { status }

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
      let(:task_user) { nil }
      let(:task_priority) { priority }
      let(:task_status) { status }

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
      let(:task_user) { user }
      let(:task_priority) { nil }
      let(:task_status) { status }

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
      let(:task_user) { user }
      let(:task_priority) { priority }
      let(:task_status) { nil }

      before do
        task.valid?
      end

      it 'エラーになる' do
        expect(task.errors[:status]).to include(I18n.t('errors.messages.required'))
      end
    end
  end
end
