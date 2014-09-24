# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

data = [
    {
        title: "Sponge",
        description: "It's a really really awesome sponge that sponges things.",
        price: 10.00,
        seller_id: 1
    },
    {
        title: "Shampoo",
        description: "Get some baller hair with this shampoo",
        price: 20.00,
        seller_id: 1
    },
    {
        title: "Soap",
        description: "Squeaky squeaky clean",
        price: 42.00,
        seller_id: 1
    }
]

u = User.create!(email: "example1@mailinator.com", password: "password")
data.each do |itemdata|
  Item.create!(itemdata)
end
