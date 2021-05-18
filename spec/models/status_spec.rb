# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Status, type: :model do
  describe 'name' do
    it '1文字以上 255文字以内 であること' do
      expect(build(:status, name: nil).valid?).to be(false)
      expect(build(:status, name: '').valid?).to be(false)
      expect(build(:status, name: 'a').valid?).to be(true)
      expect(build(:status, name: 'a' * 255).valid?).to be(true)
      expect(build(:status, name: 'a' * 256).valid?).to be(false)
    end

    context '一意性が保たれていること' do
      let!(:persisted_status) { create(:status) }

      it '登録済みでないこと' do
        expect(build(:status, name: 'hoge').valid?).to be(true)
        expect(build(:status, name: persisted_status.name).valid?).to be(false)
      end
    end
  end
end
