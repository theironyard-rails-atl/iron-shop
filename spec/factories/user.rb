FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "awfulPass"
    password_confirmation "awfulPass"
  end

  trait :shopper do
    role 'shopper'
  end
  trait :seller do
    role 'seller'
  end
end
