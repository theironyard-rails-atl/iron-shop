FactoryGirl.define do
  factory :invoice do
    user { create :user, :shopper }
    amount 1.00
  end
end
