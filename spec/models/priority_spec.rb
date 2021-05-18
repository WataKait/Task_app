# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Priority, type: :model do
  describe 'name' do
    it '1文字以上 255文字以内 であること' do
      expect(build(:priority, name: nil).valid?).to be(false)
      expect(build(:priority, name: '').valid?).to be(false)
      expect(build(:priority, name: 'a').valid?).to be(true)
      expect(build(:priority, name: 'a' * 255).valid?).to be(true)
      expect(build(:priority, name: 'a' * 256).valid?).to be(false)
    end

    it '一意性が保たれていること' do
      create(:priority, name: 'foo')

      expect(build(:priority, name: 'hoge').valid?).to be(true)
      expect(build(:priority, name: 'foo').valid?).to be(false)
    end
  end

  describe 'priority' do
    it '空文字、nil でないこと' do
      expect(build(:priority, priority: nil).valid?).to be(false)
      expect(build(:priority, priority: '').valid?).to be(false)
      expect(build(:priority, priority: 1).valid?).to be(true)
    end

    it '数値であること' do
      expect(build(:priority, priority: 10).valid?).to be(true)
      expect(build(:priority, priority: 'hoge').valid?).to be(false)
    end

    it '一意性が保たれていること' do
      create(:priority, priority: 1)

      expect(build(:priority, priority: 100).valid?).to be(true)
      expect(build(:priority, priority: 1).valid?).to be(false)
    end
  end
end
