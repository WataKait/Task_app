# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let!(:user) { create(:user, name: 'Taro') }

  let(:priority) { create(:priority, name: 'low', priority: 1) }
  let(:status) { create(:status, name: 'unstarted') }
  let(:task) { create(:task, priority: priority, status: status, user: user) }

  before do
    visit login_path
    fill_in('name', with: user.name)
    fill_in('password', with: user.password)
    click_button 'ログイン'
    click_link 'ユーザ一覧へ →'
  end

  context 'ユーザ一覧' do
    it 'hoge' do
      expect(page).to have_selector '.user_names', text: user.name
      expect(page).to have_selector '#0', text: user.tasks.size
    end
  end

  context 'ユーザ登録' do
    before do
      click_link '+ ユーザ登録'
      fill_in('user[name]', with: 'Hanako')
      fill_in('user[password]', with: 'password')
      fill_in('user[password_confirmation]', with: 'password')
    end

    it 'ユーザを登録したら、ユーザ一覧に登録したユーザが表示される' do
      click_button '作成'
      expect(page).to have_current_path users_path
      expect(page).to have_selector 'td', text: 'Hanako'
    end

    it '"ユーザ名を入力してください" と画面に表示され、登録に失敗する' do
      fill_in('user[name]', with: '')
      click_button '作成'
      expect(page).to have_content 'ユーザ名を入力してください'
    end

    it '"パスワードを入力してください" と画面に表示され、登録に失敗する' do
      fill_in('user[password]', with: '')
      click_button '作成'
      expect(page).to have_content 'パスワードを入力してください'
    end

    it '"パスワードは8文字以上で入力してください" と画面に表示され、登録に失敗する' do
      fill_in('user[password]', with: 'passwd')
      click_button '作成'
      expect(page).to have_content 'パスワードは8文字以上で入力してください'
    end

    it '"パスワード確認とパスワードの入力が一致しません" と画面に表示され、登録に失敗する' do
      fill_in('user[password_confirmation]', with: '')
      click_button '作成'
      expect(page).to have_content 'パスワード確認とパスワードの入力が一致しません'
    end
  end
end
