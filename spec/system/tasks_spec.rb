# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe 'タスク機能' do
    let!(:label) { create(:label, name: 'System Spec') }
    let!(:priority) { create(:priority, name: '中') }
    let!(:status) { create(:status, name: '着手') }
    let!(:user) { create(:user, id: 1, name: '太郎') }

    context 'タスク詳細' do
      let!(:task) { create(:task, user_id: user.id) }

      before do
        visit root_path
        click_link '詳細', href: task_path(task)
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

      it 'ボタンを押下したら作成に成功し、一覧画面へ遷移する' do
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

    context 'タスク編集' do
      let!(:task) { create(:task, user_id: user.id) }

      before do
        visit root_path
        click_link '編集', href: edit_task_path(task)
      end

      it 'タスクの情報が正しく入力欄に表示されている' do
        expect(page).to have_field('task_name', with: task.name)
        expect(page).to have_select('task_label_id', selected: task.label.name)
        expect(page).to have_select('task_priority_id', selected: task.priority.name)
        expect(page).to have_select('task_status_id', selected: task.status.name)
        expect(page).to have_field('task_time_limit', with: task.time_limit.strftime('%Y-%m-%dT%H:%M:%S'))
        expect(page).to have_field('task_description', with: task.description)
      end

      it 'ボタンを押下したら更新に成功し、一覧画面へ遷移する' do
        fill_in('task_name', with: '作業タスクA')

        click_button '更新'
        expect(page).to have_current_path tasks_path, ignore_query: true
        expect(page).to have_selector 'td', text: '作業タスクA'
      end

      it '"タスクを入力してください" と画面に表示され、更新に失敗する' do
        fill_in('task_name', with: '')

        click_button '更新'
        expect(page).to have_content 'タスクを入力してください'
      end
    end

    context 'タスク削除', js: true do
      let!(:task) { create(:task, user_id: user.id) }

      before do
        visit root_path
        click_link '削除', href: task_path(task)
      end

      it '削除確認ダイアログでキャンセルを押下したら、タスクが削除されない' do
        expect(page.dismiss_confirm).to eq '本当に削除しますか？'
        expect(page).to have_selector 'td', text: task.name
      end

      it '削除確認ダイアログで OK を押下したら、タスクが削除される' do
        expect(page.accept_confirm).to eq '本当に削除しますか？'
        expect(page).to have_content 'タスクを削除しました'
        expect(page).not_to have_selector 'td', text: task.name
      end
    end
  end
end
