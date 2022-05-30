# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザー登録のテスト' do
  before do
    visit new_user_registration_path
  end

  context '表示の確認' do
    it 'new_user_registration_pathが"/users/sign_up"であるか' do
      expect(current_path).to eq('/users/sign_up')
    end
    it '登録ボタンが表示されているか' do
      expect(page).to have_button '登録する'
    end
  end

  context 'ユーザー登録処理のテスト' do
    it '登録後のリダイレクト先は正しいか' do
      fill_in 'user[name]', with: 'Tarou'
      fill_in 'user[email]', with: 'test@example.com'
      fill_in 'user[region]', with: '東京都'
      fill_in 'user[city]', with: '渋谷区'
      fill_in 'user[birthday_year]', with: '1992'
      fill_in 'user[birthday_month]', with: '07'
      fill_in 'user[birthday_day]', with: '25'
      fill_in 'user[password]', with: '123456'
      fill_in 'user[password_confirmation]', with: '123456'
      click_button '登録する'
      expect(page).to have_current_path users_mypage_path
    end
  end
end

describe "ユーザー一覧のテスト" do
  let!(:user) { FactoryBot.create(:user) }

  before do
    visit users_path
  end

  context '表示の確認' do
    it '登録されたユーザが表示されているか' do
      expect(page).to have_content user.name
    end
  end
end

describe "ログインのテスト" do
  let(:user) { FactoryBot.create(:user) }

  before do
    visit new_user_session_path
  end

  it "ログインする" do
    user
    fill_in 'user[email]', with: 'test2@example.com'
    fill_in 'user[password]', with: '123456'
    click_button 'ログイン'
    expect(page).to have_current_path users_mypage_path
  end
end

describe "ログアウトのテスト" do
  let(:user) { FactoryBot.create(:user) }

  before do
    visit new_user_session_path
  end

  it "ログアウトする" do
    user
    fill_in 'user[email]', with: 'test3@example.com'
    fill_in 'user[password]', with: '123456'
    click_button 'ログイン'
    click_on 'ログアウト'
    expect(page).to have_current_path root_path
  end
end

describe "ユーザー詳細のテスト" do
  let!(:user) { FactoryBot.create(:user) }

  before do
    visit new_user_session_path
    user
    fill_in 'user[email]', with: 'test4@example.com'
    fill_in 'user[password]', with: '123456'
    click_button 'ログイン'
    visit user_path(user.id)
  end

  context '表示の確認' do
    it "プロフィール編集ボタンが表示されているか" do
      expect(page).to have_link "プロフィール編集", href: edit_user_path(user)
      expect(page).to have_link "FOLLOWING", href: follows_user_path(user)
      expect(page).to have_link "FOLLOWER", href: followers_user_path(user)
      expect(page).to have_link "COMMUNITY", href: communities_user_path(user)
    end
  end
end

describe "プロフィール編集画面のテスト" do
  let!(:user) { FactoryBot.create(:user) }

  before do
    visit new_user_session_path
    user
    fill_in 'user[email]', with: 'test5@example.com'
    fill_in 'user[password]', with: '123456'
    click_button 'ログイン'
    visit edit_user_path(user.id)
  end

  context '表示の確認' do
    it "保存ボタン、退会ボタンが表示されているか" do
      expect(page).to have_button "変更を保存"
      expect(page).to have_link "退会する", href: users_mypage_withdrawal_path
    end
  end
end

describe "退会画面のテスト" do
  let!(:user) { FactoryBot.create(:user) }

  before do
    visit new_user_session_path
    user
    fill_in 'user[email]', with: 'test6@example.com'
    fill_in 'user[password]', with: '123456'
    click_button 'ログイン'
    visit users_mypage_withdrawal_path
  end

  context '表示の確認' do
    it "退会する、退会ボタンが表示されているか" do
      expect(page).to have_link "退会する", href: users_mypage_withdrawal_path
      expect(page).to have_link "退会しない", href: edit_user_path(user)
    end
  end
end

describe "プロフィール編集処理のテスト" do
  let!(:user) { FactoryBot.create(:user) }

  before do
    visit new_user_session_path
    user
    fill_in 'user[email]', with: 'test7@example.com'
    fill_in 'user[password]', with: '123456'
    click_button 'ログイン'
    visit edit_user_path(user.id)
  end

  context 'ユーザー登録処理のテスト' do
    it '更新に成功しサクセスメッセージが表示されるか' do
      fill_in 'user[name]', with: 'Tarou'
      fill_in 'user[email]', with: 'test4edit@example.com'
      fill_in 'user[region]', with: '東京都'
      fill_in 'user[city]', with: '渋谷区'
      fill_in 'user[birthday_year]', with: '1992'
      fill_in 'user[birthday_month]', with: '07'
      fill_in 'user[birthday_day]', with: '25'
      click_button '変更を保存'
      expect(page).to have_content 'successfully'
    end
  end
end

describe "プロフィール編集処理のテスト" do
  let!(:user) { FactoryBot.create(:user) }

  before do
    visit new_user_session_path
    user
    fill_in 'user[email]', with: 'test8@example.com'
    fill_in 'user[password]', with: '123456'
    click_button 'ログイン'
    visit edit_user_path(user.id)
  end

  context 'ユーザー登録処理のテスト' do
    it '更新に失敗しエラーメッセージが表示されるか' do
      fill_in 'user[name]', with: ''
      fill_in 'user[email]', with: 'test9edit@example.com'
      fill_in 'user[region]', with: '東京都'
      fill_in 'user[city]', with: '渋谷区'
      fill_in 'user[birthday_year]', with: '1992'
      fill_in 'user[birthday_month]', with: '07'
      fill_in 'user[birthday_day]', with: '25'
      click_button '変更を保存'
      expect(page).to have_content 'エラー'
    end
  end
end
