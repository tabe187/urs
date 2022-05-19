# frozen_string_literal: true

require 'rails_helper'

describe "フォローテスト" do
  let!(:user){ FactoryBot.create(:user) }
  let!(:user2){ FactoryBot.create(:user) }
  before do
    visit new_user_session_path
    user
    user2
    fill_in 'user[email]', with: 'test1@example.com'
    fill_in 'user[password]', with: '123456'
    click_button 'ログイン'
    visit user_path(user2.id)
  end

  context '表示の確認' do
    it "フォローリンクが表示されているか" do
      expect(page).to have_link "フォローする", href: user_relationships_path(user2.id)
    end
  end
end

describe "フォローテスト" do
  let!(:user){ FactoryBot.create(:user) }
  let!(:user2){ FactoryBot.create(:user) }
  before do
    visit new_user_session_path
    user
    user2
    fill_in 'user[email]', with: 'test3@example.com'
    fill_in 'user[password]', with: '123456'
    click_button 'ログイン'
    visit user_path(user2.id)
  end

  context 'フォロー処理の確認' do
    it "フォロー処理が正しく行われるかのテスト" do
      click_on "フォローする"
      expect(page).to have_link "フォローを外す", href: user_relationships_path(user2.id)
    end
  end
end