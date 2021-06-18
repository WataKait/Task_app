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
    it 'ユーザ名とタスク数が表示されていること' do
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

  context 'ユーザ編集' do
    before do
      click_link '編集', href: edit_user_path(user)
    end

    it 'ユーザの情報が正しく入力欄に表示されている' do
      expect(page).to have_field('user[name]', with: user.name)
    end

    it 'ユーザを更新したら、ユーザ一覧に更新したユーザが表示される' do
      fill_in('user[name]', with: 'TaroYamada')

      click_button '更新'
      expect(page).to have_current_path users_path
      expect(page).to have_selector '.user_names', text: 'TaroYamada'
    end

    it '"ユーザ名を入力してください" と画面に表示され、更新に失敗する' do
      fill_in('user[name]', with: '')
      click_button '更新'
      expect(page).to have_content 'ユーザ名を入力してください'
    end

    it '"パスワードは8文字以上で入力してください" と画面に表示され、更新に失敗する' do
      fill_in('user[password]', with: 'passwd')
      click_button '更新'
      expect(page).to have_content 'パスワードは8文字以上で入力してください'
    end

    it '"パスワード確認とパスワードの入力が一致しません" と画面に表示され、更新に失敗する' do
      fill_in('user[password]', with: 'password')
      fill_in('user[password_confirmation]', with: '')
      click_button '更新'
      expect(page).to have_content 'パスワード確認とパスワードの入力が一致しません'
    end
  end

  context 'ユーザ削除', js: true do
    let!(:be_deleted_user) { create(:user, name: 'Hanako') }

    before do
      create(:task, user: be_deleted_user)
      click_link '削除', href: user_path(be_deleted_user)
    end

    it '削除確認ダイアログでキャンセルを押下したら、ユーザが削除されない' do
      expect(page.dismiss_confirm).to eq '本当に削除しますか？'
      expect(page).to have_selector 'td', text: be_deleted_user.name
      expect(Task.where(user: be_deleted_user).size).to eq 1
    end

    it '削除確認ダイアログで OK を押下したら、ユーザが削除される' do
      expect(page.accept_confirm).to eq '本当に削除しますか？'
      expect(page).to have_content 'ユーザを削除しました'
      expect(page).not_to have_selector 'td', text: be_deleted_user.name
      expect(Task.where(user: be_deleted_user).size).to eq 0
    end
  end
end
