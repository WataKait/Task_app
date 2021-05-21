# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe 'タスク機能' do
    let!(:label) { create(:label, name: 'System Spec') }
    let!(:priority) { create(:priority, name: '中') }
    let!(:status) { create(:status, name: '着手') }

    before do
      create(:user, id: 1, name: '太郎')
    end

    context 'タスク詳細' do
      let!(:task) { create(:task) }

      before do
        visit task_path(task)
      end

      it 'タスクの情報が正しく画面に表示されている' do
        expect(page).to have_selector 'td', text: task.name
        expect(page).to have_selector 'td', text: task.label.name
        expect(page).to have_selector 'td', text: task.priority.name
        expect(page).to have_selector 'td', text: task.status.name
        expect(page).to have_selector 'td', text: task.time_limit
        expect(page).to have_selector 'td', text: task.description
      end
    end

    context 'タスク作成' do
      before do
        visit new_task_path
        fill_in('task_name', with: '作業タスクA')
        select(label.name, from: 'task_label_id')
        select(priority.name, from: 'task_priority_id')
        select(status.name, from: 'task_status_id')
        fill_in('task_time_limit', with: '2021-01-01T00:00')
        fill_in('task_description', with: "Aという作業.\nテストです.")
      end

      it '入力値が正しく、ボタンを押下したら一覧画面へ遷移する' do
        click_button '作成'
        expect(page).to have_current_path tasks_path, ignore_query: true
      end

      it '"タスクを入力してください" と画面に表示され、作成に失敗する' do
        fill_in('task_name', with: '')

        click_button '作成'
        expect(page).to have_content 'タスクを入力してください'
      end

      it '"優先度を選択してください" と画面に表示され、作成に失敗する' do
        select('優先度を選択', from: 'task_priority_id')

        click_button '作成'
        expect(page).to have_content '優先度を選択してください'
      end

      it '"ステータスを選択してください" と画面に表示され、作成に失敗する' do
        select('ステータスを選択', from: 'task_status_id')

        click_button '作成'
        expect(page).to have_content 'ステータスを選択してください'
      end
    end
  end
end
