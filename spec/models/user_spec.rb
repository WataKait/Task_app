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

    it '一意性が保たれていること' do
      create(:user, name: '太郎')

      expect(build(:user, name: '花子').valid?).to be(true)
      expect(build(:user, name: '太郎').valid?).to be(false)
    end
  end
end
