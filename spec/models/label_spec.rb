# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Label, type: :model do
  describe 'name' do
    it '1文字以上 255文字以内 であること' do
      expect(build(:label, name: nil).valid?).to be(false)
      expect(build(:label, name: '').valid?).to be(false)
      expect(build(:label, name: 'a').valid?).to be(true)
      expect(build(:label, name: 'a' * 255).valid?).to be(true)
      expect(build(:label, name: 'a' * 256).valid?).to be(false)
    end

    context '一意性が保たれていること' do
      let!(:persisted_label) { create(:label) }

      it '登録済みでないこと' do
        expect(build(:label, name: 'hoge').valid?).to be(true)
        expect(build(:label, name: persisted_label.name).valid?).to be(false)
      end
    end
  end
end
