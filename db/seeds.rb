# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

test = User.create!({email: 'test@example.com', password: 'guest123', password_confirmation: 'guest123'})
WeightEntry.create!({value: 100, user: test, day: Date.today.strftime})
WeightEntry.create!({value: 101, user: test, day: Date.yesterday.strftime})
