FactoryBot.define do
  factory :community do
    category_id  { 2 }
    user_id  { 2 }
    title { Faker::Lorem.characters(number:6) }
    explanation { Faker::Lorem.characters(number:100) }
  end 
  
end
