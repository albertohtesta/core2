# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


user = UserRepository.find_by_email("admin@nordhen.com")
unless user
  User.create(name: "Norden Administrator", email: "admin@nordhen.com", roles: ["admin"])
  puts "User admin created!!"
end
