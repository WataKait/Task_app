# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '3ページ分のページネーションについて', type: :system do
  let!(:user) { create(:user, id: 1, name: '太郎') }
  let!(:task) { create(:task, name: 'abc_task', user_id: user.id) }

  before do
    create_list(:task, 2, user_id: user.id)
    stub_const('TasksController::RECORDS_NUMBER_TO_DISPLAY', 1)
    visit login_path
    fill_in('name', with: user.name)
    fill_in('password', with: user.password)
    click_button 'ログイン'
  end

  context '1ページ目にいる時' do
    let!(:next_page) { 2 }
    let!(:last_page) { 3 }

    it '3を押下すると3ページ目に遷移' do
      click_link '3', href: '/tasks?page=3'
      expect(page).to have_current_path '/tasks?page=3'
      expect(page).to have_css '.names'
      expect(page).to have_css '.pagination'
      expect(page.all('.names').count).to eq TasksController::RECORDS_NUMBER_TO_DISPLAY
    end

    it 'Nextを押下すると次のページに遷移' do
      click_link 'Next', href: "/tasks?page=#{next_page}"
      expect(page).to have_current_path "/tasks?page=#{next_page}"
      expect(page).to have_css '.names'
      expect(page).to have_css '.pagination'
      expect(page.all('.names').count).to eq TasksController::RECORDS_NUMBER_TO_DISPLAY
    end

    it 'Lastを押下すると最後のページに遷移' do
      click_link 'Last', href: "/tasks?page=#{last_page}"
      expect(page).to have_current_path "/tasks?page=#{last_page}"
      expect(page).to have_css '.names'
      expect(page).to have_css '.pagination'
      expect(page.all('.names').count).to eq TasksController::RECORDS_NUMBER_TO_DISPLAY
    end
  end

  context '3ページ目にいる時' do
    let!(:previous_page) { 3 }

    before do
      visit '/tasks?page=4'
    end

    it 'Firstを押下すると最初のページに遷移' do
      click_link 'First', href: tasks_path
      expect(page).to have_current_path tasks_path
      expect(page).to have_css '.names'
      expect(page).to have_css '.pagination'
      expect(page.all('.names').count).to eq TasksController::RECORDS_NUMBER_TO_DISPLAY
    end

    it 'Previousを押下すると前のページに遷移' do
      click_link 'Previous', href: "/tasks?page=#{previous_page}"
      expect(page).to have_current_path "/tasks?page=#{previous_page}"
      expect(page).to have_css '.names'
      expect(page).to have_css '.pagination'
      expect(page.all('.names').count).to eq TasksController::RECORDS_NUMBER_TO_DISPLAY
    end
  end

  context '検索結果が1件を超えない時', js: true do
    before do
      fill_in('search', with: 'abc')
      click_button '検索'
    end

    it 'ページネーションが表示されない' do
      expect(page).to have_content task.name
      expect(page).not_to have_css '.pagination'
      expect(page.all('.names').count).to eq TasksController::RECORDS_NUMBER_TO_DISPLAY
    end
  end

  context '検索結果が1件を超える時' do
    before do
      fill_in('search', with: 'task')
      click_button '検索'
    end

    it 'ページネーションが表示される' do
      expect(page).to have_css '.names'
      expect(page).to have_css '.pagination'
      expect(page.all('.names').count).to eq TasksController::RECORDS_NUMBER_TO_DISPLAY
    end
  end
end
