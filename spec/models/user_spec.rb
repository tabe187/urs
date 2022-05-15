# frozen_string_literal: true

require 'rails_helper'

describe 'モデルのテスト' do
  it "有効な内容の場合は保存されるか" do
    expect(FactoryBot.build(:user)).to be_valid
  end
end

describe 'フォローメソッドをテストする' do
    let(:user_1) { FactoryBot.create(:user) }
    let(:user_2) { FactoryBot.create(:user) }

  it "ユーザーがフォローした場合followed_idが生成されるか" do
    user_1.follow(user_2.id)
    expect(user_1.following_user.last).to eq(user_2)
  end
end

describe 'アンフォローメソッドをテストする' do
    let(:user_1) { FactoryBot.create(:user) }
    let(:user_2) { FactoryBot.create(:user) }

  it "ユーザーがフォローを外した場合followed_idが削除されるか" do
    user_1.follow(user_2.id)
    user_1.unfollow(user_2.id)
    expect(user_1.following_user.last).not_to eq(user_2)
  end
end