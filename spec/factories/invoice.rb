FactoryGirl.define do
  factory :invoice do
    shopper { create :user, :shopper }
    amount 1.00
    paid false
  end
end
