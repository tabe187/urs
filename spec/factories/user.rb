FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number:5) }
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(number:6) }
    region { Faker::Lorem.characters(number:5) }
    city { Faker::Lorem.characters(number:5) }
    hobby { Faker::Lorem.characters(number:5) }
    profile { Faker::Lorem.characters(number:5) }
    birthday_year { Faker::Number.number(digits: 4) }
    birthday_month { Faker::Number.number(digits: 2) }
    birthday_day { Faker::Number.number(digits: 2) }
    gender { 0 }
  end
  
end


  # factory :user do
  #   name { "Tarou" }
  #   email { "test@example.com" }
  #   password { "tanaka0401" }
  #   region { "東京都" }
  #   city { "渋谷区" }
  #   hobby { "サイクリング" }
  #   profile { "近所のお気に入りのお店を共有したい" }
  #   birthday_year { "1996" }
  #   birthday_month { "06" }
  #   birthday_day { "25" }
  #   gender { 0 }
  # end