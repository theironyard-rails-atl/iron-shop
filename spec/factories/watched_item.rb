FactoryGirl.define do
  factory :watched_item do
    user { create :user, :shopper }
    item { create :item }
  end
end
