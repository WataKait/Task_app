# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '名前' do
    it '1文字以上 255文字以内 であること' do
      expect(build(:user, name: nil).valid?).to be(false)
      expect(build(:user, name: '').valid?).to be(false)
      expect(build(:user, name: 'a').valid?).to be(true)
      expect(build(:user, name: 'a' * 255).valid?).to be(true)
      expect(build(:user, name: 'a' * 256).valid?).to be(false)
    end

    it '一意性が保たれていること' do
      create(:user, name: '太郎')

      expect(build(:user, name: '花子').valid?).to be(true)
      expect(build(:user, name: '太郎').valid?).to be(false)
    end
  end

  describe 'パスワード' do
    it 'パスワード確認と一致すること' do
      expect(build(:user, password: 'password', password_confirmation: 'pass_word').valid?).to be(false)
      expect(build(:user, password: 'password', password_confirmation: 'password').valid?).to be(true)
    end

    it '8文字以上 255文字以内 であること' do
      expect(build(:user, password: nil, password_confirmation: nil).valid?).to be(false)
      expect(build(:user, password: '', password_confirmation: '').valid?).to be(false)
      expect(build(:user, password: 'a' * 7, password_confirmation: 'a' * 7).valid?).to be(false)
      expect(build(:user, password: 'a' * 8, password_confirmation: 'a' * 8).valid?).to be(true)
      expect(build(:user, password: 'a' * 255, password_confirmation: 'a' * 255).valid?).to be(true)
      expect(build(:user, password: 'a' * 256, password_confirmation: 'a' * 256).valid?).to be(false)
    end
  end

  describe 'ユーザ削除' do
    let!(:user) { create(:user, name: '太郎') }

    before do
      create(:task, user: user)
    end

    it '紐づいているタスクも削除されること' do
      expect(Task.where(user: user).size).to eq 1

      user.destroy
      expect(Task.where(user: user).size).to eq 0
    end
  end
end
