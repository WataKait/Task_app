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

  context 'ユーザ削除', js: true do
    let!(:be_deleted_user) { create(:user, name: 'Hanako') }

    before do
      click_link '削除', href: user_path(be_deleted_user)
    end

    it '削除確認ダイアログでキャンセルを押下したら、ユーザが削除されない' do
      expect(page.dismiss_confirm).to eq '本当に削除しますか？'
      expect(page).to have_selector 'td', text: be_deleted_user.name
    end

    it '削除確認ダイアログで OK を押下したら、ユーザが削除される' do
      expect(page.accept_confirm).to eq '本当に削除しますか？'
      expect(page).to have_content 'ユーザを削除しました'
      expect(page).not_to have_selector 'td', text: be_deleted_user.name
    end
  end
end
