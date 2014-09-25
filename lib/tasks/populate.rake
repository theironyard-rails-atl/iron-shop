namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    require 'faker'
    make_users_and_items
  end
end

def make_users_and_items
  10.times do |n|
    User.create!(email: Faker::Internet.email,
      password: "password",
      password_confirmation: "password")

    Item.create!(seller_id: 1,
      title: Faker::App.name,
      description: Faker::Hacker.say_something_smart,
      price: Faker::Commerce.price)
  end
end
