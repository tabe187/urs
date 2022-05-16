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

