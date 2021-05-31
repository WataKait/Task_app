# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Status, type: :model do
  describe 'ステータス名' do
    it '1文字以上 255文字以内 であること' do
      expect(build(:status, name: nil).valid?).to be(false)
      expect(build(:status, name: '').valid?).to be(false)
      expect(build(:status, name: 'a').valid?).to be(true)
      expect(build(:status, name: 'a' * 255).valid?).to be(true)
      expect(build(:status, name: 'a' * 256).valid?).to be(false)
    end

    it '一意性が保たれていること' do
      create(:status, name: '着手')

      expect(build(:status, name: '未着手').valid?).to be(true)
      expect(build(:status, name: '着手').valid?).to be(false)
    end
  end

  describe '.search' do
    let!(:unstarted) { create(:status, name: '未着手') }
    let!(:started) { create(:status, name: '着手') }
    let!(:completed) { create(:status, name: '完了') }

    it "'未着手' で検索したら '未着手' が返る" do
      expect(described_class.search('未着手')).to include(unstarted)
      expect(described_class.search('未着手')).not_to include(started, completed)
    end

    it "'着手' で検索したら '未着手・着手' が返る" do
      expect(described_class.search('着手')).to include(unstarted, started)
      expect(described_class.search('着手')).not_to include(completed)
    end

    it "'これから' で検索したら 空の値が返る" do
      expect(described_class.search('これから')).to be_empty
    end

    it "'' で検索したら 全て返る" do
      expect(described_class.search('')).to include(unstarted, started, completed)
    end
  end
end
