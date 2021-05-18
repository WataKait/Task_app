# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'name' do
    it '1文字以上 255文字以内 であること' do
      expect(build(:task, name: nil).valid?).to be(false)
      expect(build(:task, name: '').valid?).to be(false)
      expect(build(:task, name: 'a').valid?).to be(true)
      expect(build(:task, name: 'a' * 255).valid?).to be(true)
      expect(build(:task, name: 'a' * 256).valid?).to be(false)
    end
  end

  describe 'user' do
    let(:user) { create(:user) }

    it 'nil でないこと' do
      expect(build(:task, user: nil).valid?).to be(false)
      expect(build(:task, user: user).valid?).to be(true)
    end
  end

  describe 'priority' do
    let(:priority) { create(:priority) }

    it 'nil でないこと' do
      expect(build(:task, priority: nil).valid?).to be(false)
      expect(build(:task, priority: priority).valid?).to be(true)
    end
  end

  describe 'status' do
    let(:status) { create(:status) }

    it 'nil でないこと' do
      expect(build(:task, status: nil).valid?).to be(false)
      expect(build(:task, status: status).valid?).to be(true)
    end
  end
end
