# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

partner = Partner.create(:name => "Forest", :country => "UK", :city => "London", :scheduled_date => "2017-12-20")
puts "PARTNER: #{partner.inspect}"
