# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

jon = User.create(username: "jman")
justine = User.create(username: "boosh")

house = List.create(title: "House", due_date: "April 15")
wedding = List.create(title: "Wedding", due_date: "Sept 6")

jon.lists << house

justine.lists << house
justine.lists << wedding

taska = Task.create(name: "Wash car", description: "Wash the Toyota with soap and water", due_date: "April 10")
taskb = Task.create(name: "Do dishes", description: "Put the dishes in the dishwasher", due_date: "April 1")
taskc = Task.create(name: "Hire photographer", description: "Get quotes and choose a photographer", due_date: "Sept 6")

house.tasks << taska
house.tasks << taskb
wedding.tasks << taskc
