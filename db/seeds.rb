# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



Cat.create(name: "Joe", description: "fluffy", color: "black", birth_date: Date.today - 450, sex: "M")
Cat.create(name: "Sarah", description: "fuzzy", color: "white", birth_date: Date.today - 976, sex: "F")
Cat.create(name: "Molly", description: "hairy", color: "black", birth_date: Date.today - 523, sex: "F")

CatRentalRequest.create(cat_id: 1, start_date: Date.today - 30, end_date: Date.today, status: "APPROVED")
CatRentalRequest.create(cat_id: 1, start_date: Date.today + 1, end_date: Date.today + 12, status: "PENDING")
