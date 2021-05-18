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

    it '一意性が保たれていること' do
      create(:label, name: 'test')

      expect(build(:label, name: 'RSpec').valid?).to be(true)
      expect(build(:label, name: 'test').valid?).to be(false)
    end
  end
end
