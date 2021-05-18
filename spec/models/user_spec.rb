# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'user' do
    it '1文字以上 255文字以内 であること' do
      expect(build(:user, name: nil).valid?).to be(false)
      expect(build(:user, name: '').valid?).to be(false)
      expect(build(:user, name: 'a').valid?).to be(true)
      expect(build(:user, name: 'a' * 255).valid?).to be(true)
      expect(build(:user, name: 'a' * 256).valid?).to be(false)
    end

    context '一意性が保たれていること' do
      let!(:persisted_user) { create(:user) }

      it '登録済みでないこと' do
        expect(build(:user, name: 'hoge').valid?).to be(true)
        expect(build(:user, name: persisted_user.name).valid?).to be(false)
      end
    end
  end
end
