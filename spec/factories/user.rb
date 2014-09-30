FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "awfulPass"
    password_confirmation "awfulPass"
    role "shopper"
  end

  trait :shopper do
    # v- DB column role
    role 'shopper'
  end
  trait :seller do
    role 'seller'
  end
  trait :admin do
    role 'admin'
  end
  trait :banned do
    role 'banned'
  end
end
