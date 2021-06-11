# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'LoginLogout', type: :system do
  let!(:user) { create(:user, name: 'taro', password: 'password', password_confirmation: 'password') }

  context 'ログイン' do
    before do
      visit login_path
      fill_in('name', with: user.name)
      fill_in('password', with: user.password)
    end

    it '成功したらタスク一覧画面にユーザ名が表示されること' do
      click_button 'ログイン'
      expect(page).to have_current_path tasks_path
      expect(page).to have_content user.name
    end

    it '失敗したらログイン画面にフラッシュメッセージが表示されること' do
      fill_in('password', with: 'pass_word')
      click_button 'ログイン'
      expect(page).to have_current_path login_path
      expect(page).to have_content 'ユーザ名またはパスワードが違います'
    end
  end

  context 'ログアウト' do
    before do
      visit login_path
      fill_in('name', with: user.name)
      fill_in('password', with: user.password)
      click_button 'ログイン'
    end

    it '成功したらログイン画面に遷移されること' do
      expect(page).to have_current_path tasks_path
      click_link 'ログアウト', href: logout_path
      expect(page).to have_current_path login_path
    end
  end
end
