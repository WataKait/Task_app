# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let!(:user) { create(:user, name: 'Taro') }

  let(:priority) { create(:priority, name: 'low', priority: 1) }
  let(:status) { create(:status, name: 'unstarted') }
  let(:task) { create(:task, priority: priority, status: status, user: user) }

  context 'ユーザ一覧' do
    before do
      visit login_path
      fill_in('name', with: user.name)
      fill_in('password', with: user.password)
      click_button 'ログイン'
      click_link 'ユーザ一覧へ →'
    end

    it 'hoge' do
      expect(page).to have_selector '.user_names', text: user.name
      expect(page).to have_selector '#0', text: user.tasks.size
    end
  end
end
