FactoryBot.define do
  factory :community do
    category_id  { 1 }
    user_id  { 1 }
    title { Faker::Lorem.characters(number:6) }
    explanation { Faker::Lorem.characters(number:100) }
  end 
  
end
