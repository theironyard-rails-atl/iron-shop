require 'rails_helper'

describe WatchedItem do
  %i(user item).each do |field|
    it "requires a #{field}" do
      watched_item = build :watched_item, field => nil
      expect( watched_item.valid?).to eq false
    end
  end
end
