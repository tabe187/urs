# frozen_string_literal: true

require 'rails_helper'

describe 'モデルのテスト' do
    let(:user) { FactoryBot.create(:user) }
    let(:category) { FactoryBot.create(:category) }
  it "有効な内容の場合は保存されるか" do
    user
    category
    expect(FactoryBot.build(:community)).to be_valid
  end
end

describe 'コミュニテイへの参加状況を確認するテスト' do
    let(:user) { FactoryBot.create(:user) }
    let(:category) { FactoryBot.create(:category) }
    let(:community) { FactoryBot.create(:community) }
    let(:participant) { FactoryBot.create(:participant) }
  it "参加している場合trueが返される" do
    user
    category
    community
    participant
    expect(community.participated_by?(user)).to eq(true)
  end
end

describe 'コミュニテイへの参加場合通知されるかテストする' do
    let(:user) { FactoryBot.create(:user) }
    let(:category) { FactoryBot.create(:category) }
    let(:community) { FactoryBot.create(:community) }
    let(:participant) { FactoryBot.create(:participant) }
  it "レコードが存在しない場合trueを返す" do
    user
    category
    community
    participant
    community.create_notification_like!(user)
    expect(Notification.where(["visitor_id = ? and visited_id = ? and community_id = ? and action = ? ",user.id, community.user_id, community.id, 'like']).present?).to eq(true)
  end
end

# describe 'コミュニテイへの参加場合通知されるかテストする' do
#     let(:user_1) { FactoryBot.create(:user) }
#     let(:user_2) { FactoryBot.create(:user) }
#     let(:category) { FactoryBot.create(:category) }
#     let(:community) { FactoryBot.create(:community) }
#     let(:participant) { FactoryBot.create(:participant) }
#   it "レコードが存在しない場合trueを返す" do
#     user_1
#     user_2
#     category
#     community
#     participant
#     byebug
#     community.create_notification_like!(user_2)
#     expect(Notification.where(["visitor_id = ? and visited_id = ? and community_id = ? and action = ? ",user_1.id, community.user_id, community.id, 'like']).present?).to eq(false)
#   end
# end