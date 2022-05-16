# frozen_string_literal: true

require 'rails_helper'

describe 'モデルのテスト' do
  it "有効な内容の場合は保存されるか" do
    user = FactoryBot.create(:user)
　　category = FactoryBot.create(:category, user: user)
　　community = FactoryBot.create(:community, category: category, user: user)
    expect(FactoryBot.build(:community)).to be_valid
  end
end