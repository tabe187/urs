# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
    email: 'admin@gmail.com',
    password: '123456',
)

users = [
  { name: '田中ゆうこ', birthday_year: 1993 },
  { name: '森山太郎', birthday_year: 1988 },
  { name: '山田太郎', birthday_year: 1976 },
  { name: '秋山なお', birthday_year: 2000 }
]
User.create(users)