FactoryGirl.define do
  factory :item do
    title       { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence rand 1..3 }
    price       { Faker::Commerce.price }
    seller      { create :user, :seller }
  end
end
