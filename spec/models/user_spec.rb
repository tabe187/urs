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
    expect(user_1.following_users.last).to eq(user_2)
  end
end

describe 'アンフォローメソッドをテストする' do
    let(:user_1) { FactoryBot.create(:user) }
    let(:user_2) { FactoryBot.create(:user) }

  it "ユーザーがフォローを外した場合followed_idが削除されるか" do
    user_1.follow(user_2.id)
    user_1.unfollow(user_2.id)
    expect(user_1.following_users.last).not_to eq(user_2)
  end
end

describe 'フォローしていればtrueを返すかテストする' do
    let(:user_1) { FactoryBot.create(:user) }
    let(:user_2) { FactoryBot.create(:user) }

  it "ユーザーがフォローをしていればtrueを返す" do
    user_1.follow(user_2.id)
    expect(user_1.following?(user_2)).to eq(true)
  end
end

describe '新たにフォローした場合通知されるかテストする' do
    let(:user_1) { FactoryBot.create(:user) }
    let(:user_2) { FactoryBot.create(:user) }

  it "レコードが存在しない場合trueを返す" do
    user_1.follow(user_2.id)
    user_2.create_notification_follow!(user_1)
    expect(Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",user_1.id, user_2.id, 'follow']).present?).to eq(true)
  end
end
