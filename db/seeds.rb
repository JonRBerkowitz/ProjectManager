# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

jon = User.create(email: "jman", password: "password")

house = Project.create(name: "House", due_date: "April 15")

t = Task.create(name: "test task". user_id: 1, project_id: 1)