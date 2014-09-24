FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "awfulPass"
    password_confirmation "awfulPass"
  end

  trait :shopper do
    # v- DB column role
  end
  trait :seller do
    seller true
    shopper false
  end
end
