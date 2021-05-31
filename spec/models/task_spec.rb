# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'タスク名' do
    it '1文字以上 255文字以内 であること' do
      expect(build(:task, name: nil).valid?).to be(false)
      expect(build(:task, name: '').valid?).to be(false)
      expect(build(:task, name: 'a').valid?).to be(true)
      expect(build(:task, name: 'a' * 255).valid?).to be(true)
      expect(build(:task, name: 'a' * 256).valid?).to be(false)
    end
  end

  describe 'user_id' do
    let(:user) { create(:user) }

    it 'nil でないこと' do
      expect(build(:task, user_id: nil).valid?).to be(false)
      expect(build(:task, user_id: user.id).valid?).to be(true)
    end
  end

  describe 'priority_id' do
    let(:priority) { create(:priority) }

    it 'nil でないこと' do
      expect(build(:task, priority_id: nil).valid?).to be(false)
      expect(build(:task, priority_id: priority.id).valid?).to be(true)
    end
  end

  describe 'status_id' do
    let(:status) { create(:status) }

    it 'nil でないこと' do
      expect(build(:task, status_id: nil).valid?).to be(false)
      expect(build(:task, status_id: status.id).valid?).to be(true)
    end
  end

  describe 'search メソッド' do
    let!(:abc_task) { create(:task, name: 'abcタスク', user_id: user.id) }
    let!(:other_task) { create(:task, name: 'xyz', user_id: user.id) }
    let!(:user) { create(:user) }
    let(:status_ids) { [] }

    it "'abc' で検索したら 'abcタスク' が返る" do
      expect(described_class.search('abc', status_ids, user.id)).to include(abc_task)
    end

    it "'abcd' で検索したら 空の値が返る" do
      expect(described_class.search('abcd', status_ids, user.id)).to be_empty
    end

    it "'' で検索したら 全て返る" do
      expect(described_class.search('', status_ids, user.id)).to include(abc_task, other_task)
    end
  end
end
