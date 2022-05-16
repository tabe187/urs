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
      # fill_in 'user[gender]', with: 'man'
      fill_in 'user[password]', with: '123456'
      fill_in 'user[password_confirmation]', with: '123456'
      click_button '登録する'
      expect(page).to have_current_path users_mypage_path
    end
  end
end

describe "ユーザー一覧のテスト" do
  let!(:user){ FactoryBot.create(:user) }

  before do
    visit users_path
  end
  context '表示の確認' do
    it '登録されたユーザが表示されているか' do
      expect(page).to have_content user.name
    end
  end
end

describe "ログイン・ログアウトのテスト" do
  let!(:user){ FactoryBot.create(:user) }
  before do
    visit new_user_session_path
  end  
  it "ログインする" do
    fill_in 'user[email]', with: 'user.email'
    fill_in 'user[password]', with: 'user.password'
    click_button 'ログイン'
    expect(page).to have_current_path users_mypage_path
  end

end


# describe "ユーザー詳細のテスト" do
#   let!(:user){ FactoryBot.create(:user) }

#   context '表示の確認' do
#     it "プロフィール編集ボタンが表示されているか" do
#       visit user_path(user.id)
#       expect(page).to have_link "プロフィール編集", link_to: edit_user_path(user.id)
#     end
#   end
# end

